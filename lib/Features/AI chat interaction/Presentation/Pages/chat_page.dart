import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Data/chatservice.dart';
import '../Widgets/ai_voice_bottomsheet.dart';
import 'chat_history.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  String conversationID;
  final String initialQuery;
  ChatPage(
      {super.key, required this.conversationID, required this.initialQuery});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final StreamController<List<Map<String, dynamic>>> _chatStreamController =
      StreamController.broadcast();
  List<Map<String, dynamic>> _messages = [];
  final AIChat _chatService = AIChat();
  bool _isLoading = true;
  bool _isAwaitingResponse = false;

  @override
  void initState() {
    super.initState();
    if (widget.conversationID.isNotEmpty && widget.initialQuery.isEmpty) {
      // Navigated from Chat History
      _searchController.clear();
      _fetchPreviousChats();
    } else {
      // Navigated from New Chat
      _searchController.text = widget.initialQuery;
      _isLoading = false;

      // Instantly show the user message before hitting API
      _messages.add({"text": widget.initialQuery, "role": "user"});
      _chatStreamController.add(_messages);

      // Call API in background
      Future.delayed(Duration(milliseconds: 100),
          () => _sendMessage(isFirstMessage: true));
    }
  }

  void _fetchPreviousChats() async {
    if (widget.conversationID.isNotEmpty) {
      var response = await _chatService.loadChats(widget.conversationID);
      if (response.isNotEmpty) {
        setState(() {
          _messages = List<Map<String, dynamic>>.from(
              response["messages"].map((msg) => {
                    "text": msg["text"],
                    "role": msg["role"] // user or model
                  }));
          _chatStreamController.add(_messages);
          _isLoading = false; //  Stop loading after messages are fetched
        });
      } else {
        setState(() {
          _isLoading = false; //  Stop loading if API returns empty
        });
      }
    }
  }

  void _sendMessage({bool isFirstMessage = false}) async {
    if (_searchController.text.trim().isEmpty) return;

    String query = _searchController.text.trim();
    _searchController.clear();

    // Add user message to stream
    if (!isFirstMessage) {
      _messages.add({"text": query, "role": "user"});
      _chatStreamController.add(_messages);
    }

    setState(() {
      _isAwaitingResponse = true;
    });

    // Hit API based on whether chat is new or existing
    Map<String, dynamic> response;
    if (widget.conversationID.isNotEmpty) {
      response = await _chatService.continueChat(widget.conversationID, query);
    } else {
      response = await _chatService.newChat(query);
      if (response.isNotEmpty && response.containsKey("conversation_id")) {
        // Store the new conversation ID for future messages
        widget.conversationID = response["conversation_id"];
      }
    }

    if (response.isNotEmpty) {
      setState(() {
        _isAwaitingResponse = false;
        _messages.add({"text": response["model_response"], "role": "model"});
        _chatStreamController.add(_messages);
      });

      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _chatStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navbar
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCircularButton(Icons.keyboard_arrow_left, () {
                    Navigator.of(context).pop();
                  }),
                  const Text(
                    "Chat",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  _buildCircularButton(Icons.history, () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatHistory()));
                  }),
                ],
              ),
            ),

            // Chat List
            Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _chatStreamController.stream,
                    builder: (context, snapshot) {
                      if (_isLoading) {
                        return Center(
                            child:
                                CircularProgressIndicator()); //  Show loader while fetching
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No messages yet"));
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length +
                            (_isAwaitingResponse ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.length &&
                              _isAwaitingResponse) {
                            return _buildTypingIndicator(); //  Show loader
                          }
                          final msg = snapshot.data![index];
                          bool isUser = msg["role"] == "user";
                          return _buildChatBubble(msg["text"]!, isUser);
                        },
                      );
                    })),

            // Input Field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Type a message..",
                        fillColor: Colors.white,
                        prefixIcon:
                            _buildIconContainer(Icons.insert_photo_outlined),
                        suffixIcon: GestureDetector(
                          onTap: () => bottomsheet(context),
                          child: const Icon(Icons.graphic_eq,
                              size: 25, color: Colors.black54),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildSendButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Loader for AI Typing
  Widget _buildTypingIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          _buildProfileImage("assets/images/ai.png"),
          SizedBox(width: 10),
          LoadingAnimationWidget.waveDots(
              color: Colors.grey, size: 50), // 🔹 Wave Dots Loader
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isUser
            ?
            // Question
            Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Row(
                  children: [
                    _buildProfileImage("assets/images/profile.png"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MarkdownBody(
                        data: utf8
                            .decode(text.codeUnits), // Ensures emoji display
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //  Text(
                      //   utf8.decode(text.codeUnits),
                      //   style: const TextStyle(fontFamily: "Poppins", fontSize: 19, fontWeight: FontWeight.w500),
                      // ),
                    ),
                  ],
                ),
              )
            :
            // Answer Bubble
            Container(
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 225, 240, 226),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileImage("assets/images/ai.png"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MarkdownBody(
                        data: utf8
                            .decode(text.codeUnits), // Ensures emoji display
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Text(
                      //   utf8.decode(text.codeUnits),
                      //   style: const TextStyle(fontFamily: "Poppins", fontSize: 17,fontWeight: FontWeight.w500),
                      // ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  // Circular Buttons
  Widget _buildCircularButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          // ignore: deprecated_member_use
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
          ],
        ),
        child: Icon(icon, size: 28, color: Colors.black87),
      ),
    );
  }

  // Profile Image
  Widget _buildProfileImage(String imagePath) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 186, 232, 210)),
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset(imagePath, fit: BoxFit.cover)),
    );
  }

  // Icon Container
  Widget _buildIconContainer(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration:
            BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
        child: Icon(icon, size: 25, color: Colors.black54),
      ),
    );
  }

  // Send Button
  Widget _buildSendButton() {
    return
        //IconButton(onPressed: _sendMessage, icon: Icon(Icons.send,color: Colors.white,),colo: Colors.black,);
        GestureDetector(
      onTap: () {
        if (_searchController.text.trim().isNotEmpty) {
          _sendMessage();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Please Enter text first",
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.white60,
          ));
        }
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }
}
