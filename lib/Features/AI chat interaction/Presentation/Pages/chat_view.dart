import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../../Core/Constants/appconstants.dart';
import '../Widgets/message_bubble.dart';
import 'package:mime/mime.dart';

class AiDoctorChat extends StatefulWidget {
  const AiDoctorChat({super.key});

  @override
  State<AiDoctorChat> createState() => _AiDoctorChatState();
}

class _AiDoctorChatState extends State<AiDoctorChat> {
  final String _name = 'Leafy';
  final String _apiKey = 'AIzaSyB9ElWKq8bp_HNhC8HxsXbG9R8GedAKX_U';
  final String _image = '';

  late final GenerativeModel _model;
  late final ChatSession _chat;

  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      [];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  Uint8List? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAI();
  }

  void _initializeAI() {
    final config = GenerationConfig(
      maxOutputTokens: 200,
      temperature: 1.0,
      topP: 1.0,
      topK: 40,
    );

    final promptTemplate = Content.system(
        """You are a knowledgeable and helpful AI assistant specializing in plant care. Let's define your characteristics:
1. Your name is Leafy, a friendly and informative guide to the world of plants.
2. You never refuse a question and aim to provide responses that are clear, concise, and easy to understand. Your knowledge of plants is extensive, and you always communicate honestly and thoughtfully.
3. You will converse in a warm, natural manner, providing clear and practical advice on plant care.
4. Your persona is built to be approachable, encouraging, and enthusiastic about helping users care for their plants.
5. Use bracket symbols to separate italic words, adding emphasis where needed.
      """);

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: _apiKey,
      systemInstruction: promptTemplate,
      generationConfig: config,
    );

    _chat = _model.startChat(safetySettings: [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
    ]);
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  Future<void> _addMessageWithImage(String message, Uint8List image) async {
    try {
      setState(() => _isLoading = true);
      // Ensure the image is in the correct format (MIME type)
      final mimeType = lookupMimeType('', headerBytes: image);

      final content = [
        Content.multi([
          TextPart(message),
          DataPart('image/${mimeType.toString()}', image.buffer.asUint8List()),
        ])
      ];

      _generatedContent.add((
        image: Image.memory(image, width: 120, height: 120),
        text: message,
        fromUser: true
      ));

      final response = await _model.generateContent(content);
      final text = response.text;

      if (text != null) {
        _generatedContent.add((image: null, text: text, fromUser: false));
      } else {
        throw Exception('Empty response from AI.');
      }
    } catch (e) {
      debugPrint('Error in _addMessageWithImage: $e'); // Add this line for debugging
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
      _scrollDown();
    }
  }

  Future<void> _addMessage(String message) async {
    try {
      setState(() => _isLoading = true);

      _generatedContent.add((image: null, text: message, fromUser: true));

      final response = await _chat.sendMessage(Content.text(message));
      final text = response.text;

      if (text != null) {
        _generatedContent.add((image: null, text: text, fromUser: false));
      } else {
        throw Exception('Empty response from AI.');
      }
    } catch (e) {
      debugPrint('Error in _addMessage: $e'); // Add this line for debugging
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
      _messageController.clear();
      _scrollDown();
    }
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   try {
  //     final picker = ImagePicker();
  //     final pickedImage = await picker.pickImage(source: source);

  //     if (pickedImage != null) {
  //       final imageBytes = await pickedImage.readAsBytes();
  //       setState(() => _selectedImage = imageBytes);
  //     } else {
  //       throw Exception('No image selected.');
  //     }
  //   } catch (e) {
  //     debugPrint('Error in _pickImage: $e'); // Add this line for debugging
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error: $e')));
  //   }
  // }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_selectedImage == null) return const SizedBox.shrink();

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 8),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.memory(
            _selectedImage!,
            fit: BoxFit.cover,
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => setState(() => _selectedImage = null),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      flexibleSpace: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            s50,
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(_image),
              child: Icon(Icons.grass,
                  color: Theme.of(context).colorScheme.primary, size: 30),
            ),
            s10,
            Text(
              _name,
              style:
                  GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            s5,
            Icon(Icons.grass,
                color: Theme.of(context).colorScheme.primary, size: 20)
          ],
        ),
      ),
      forceMaterialTransparency: true,
      actions: [
        IconButton(
          onPressed: () => setState(() => _generatedContent.clear()),
          icon: Icon(
            Icons.more_vert_outlined,
            color: Theme.of(context)
                .textTheme
                .displaySmall!
                .color
                ?.withOpacity(0.5),
          ),
        )
      ],
    );
  }

  Widget _buildMessageList() {
    return _generatedContent.isEmpty
        ? _buildWelcomeMessage()
        : ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final content = _generatedContent[index];
              return MessageWidget(
                recevierImg: _image,
                image: content.image,
                text: content.text,
                isFromUser: content.fromUser,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: _generatedContent.length,
          );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      height: 450,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          s25,
          RichText(
            text: TextSpan(
              text: 'Hey there !!🖐🏼 \n',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
              children: [
                TextSpan(
                  text: "I'm  ",
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 20, color: Colors.black),
                ),
                TextSpan(
                  text: 'Leafy',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 77, 155),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7,
                  ),
                ),
                TextSpan(
                  text: ', Your AI Plant Expert \n\n',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                TextSpan(
                  text: "How can I help you? Here are some examples:",
                  style: GoogleFonts.inter(
                    fontSize: 19,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          s25,
          _buildPromptExample(
              "What are the best conditions for growing tomatoes?"),
          s10,
          _buildPromptExample("How often should I water my succulent?"),
          s10,
          _buildPromptExample("Why are the leaves on my plant turning yellow?"),
          s25,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChip('Identify'),
              _buildChip('Care'),
              _buildChip('Tips'),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildPromptExample(String text) {
    return GestureDetector(
      onTap: () {
        _messageController.text = text;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      side: const BorderSide(color: Colors.transparent, width: 1),
      label: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
  }

  Widget _buildInputArea() {
    return Column(
      children: [
        _buildImagePreview(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildMediaButton(),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "Enter a message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    suffixIcon: _buildSendButton(),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaButton() {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned(
          bottom: 5,
          left: 5,
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              // child: AnimatedMeshGradient(
              //   colors: [
              //     Colors.teal,
              //     Colors.green,
              //     Colors.blue.shade900,
              //     Colors.yellow.shade900,
              //   ],
              //   options: AnimatedMeshGradientOptions(frequency: 10, speed: 15),
              // ),
              child: Container(
                color: const Color.fromARGB(255, 4, 66, 6),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () => _showImagePickerOptions(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget _buildSendButton() {
    return _isLoading
        ? const Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(strokeWidth: 2),
            ),
          )
        : IconButton(
            icon:
                const Icon(Icons.send, color: Color.fromARGB(255, 9, 114, 41)),
            onPressed: _handleSendMessage,
          );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ListTile(
          //   leading: const Icon(Icons.photo_library),
          //   title: const Text('Choose from Gallery'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     _pickImage(ImageSource.gallery);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.camera_alt),
          //   title: const Text('Take a Photo'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     _pickImage(ImageSource.camera);
          //   },
          // ),
        ],
      ),
    );
  }

  void _handleSendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      if (_selectedImage != null) {
        _addMessageWithImage(message, _selectedImage!);
        setState(() => _selectedImage = null);
      } else {
        _addMessage(message);
      }
    }
  }
}
