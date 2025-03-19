import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/Features/Community/Data/community_services.dart';
import 'dart:io';

import 'package:myapp/Features/Community/Presentation/Widgets/custom_appbar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController plantNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController questionController = TextEditingController();

  final TextEditingController tagsController = TextEditingController();
  String selectedAlertStatus = "Low";

  final ImagePicker _picker = ImagePicker();
  List<File> selectedMedia = [];

  /// Function to pick image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedMedia.add(File(image.path));
      });
    }
  }

  /// Function to pick video
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        selectedMedia.add(File(video.path));
      });
    }
  }

  /// Function to remove selected media
  void _removeMedia(int index) {
    setState(() {
      selectedMedia.removeAt(index);
    });
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }
  @override
  void dispose() {
   descriptionController.dispose();
    plantNameController.dispose();
    questionController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  void _clearData() {
    descriptionController.clear();
    plantNameController.clear();
    questionController.clear();
    tagsController.clear();
    selectedMedia = [];
    selectedAlertStatus = "Low";

    setState(() {});
  }

  /// Function to validate and post
  void _postToCommunity() async {
    if (plantNameController.text.trim().isNotEmpty &&
        questionController.text.trim().isNotEmpty) {
      String status = await CommunityMethods().createPost(
          plantName: plantNameController.text,
          question: questionController.text,
          alertStatus: selectedAlertStatus,
          description: descriptionController.text,
          hashtags: tagsController.text,
          media: selectedMedia);

      if (status == "success") {
        _showSnackBar("Post submitted successfully!", Colors.green);
      } else {
        _showSnackBar("Post Failed! Try Again", Colors.red);
      }
      _clearData();
      Navigator.of(context).pop();
    } else {
      _showSnackBar("Please Enter PlantName, Question/Thoughts", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromRGBO(245, 246, 247, 1),
      // appBar: AppBar(
      //   title: Text(
      //     'Create Post',
      //     style: TextStyle(
      //         fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w600),
      //   ),
      //   forceMaterialTransparency: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSectionTitle("Create Post"),
                  const SizedBox(height: 10),
                  _buildTextField(plantNameController, "Plant Name"),
                  _buildTextField(questionController, "Questions/Thoughts"),
                  _buildTextField(descriptionController, "Description/Message",
                      maxLines: 4),
                  const SizedBox(height: 10),
                  _buildMediaButtons(),
                  const SizedBox(height: 10),
                  _buildSelectedMediaList(),
                  const SizedBox(height: 20),
                  _buildAlertDropdown(),
                  const SizedBox(height: 15),
                  _buildTextField(
                      tagsController, "Add tags (separated by comma)"),
                  const SizedBox(height: 20),
                  _buildPostButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///  Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.black12,
          radius: 24,
          child: Icon(Icons.person, color: Colors.black),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  /// Common TextField Widget
  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  /// Media Buttons (Images & Video)
  Widget _buildMediaButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _pickImage,
            style: _buttonStyle(),
            icon: const Icon(Icons.image, size: 30),
            label: const Text(
              "Add Images",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _pickVideo,
            style: _buttonStyle(),
            icon: const Icon(Icons.videocam, size: 30),
            label: const Text(
              "Add Video",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  ///  List of Selected Media (Wrap Widget + Fixed Scroll)

  Widget _buildSelectedMediaList() {
    return selectedMedia.isNotEmpty
        ? Container(
            height: 120,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black26),
            ),
            child: Wrap(
              spacing: 8,
              children: List.generate(selectedMedia.length, (index) {
                return Chip(
                  label: Text(
                    "Media ${index + 1}",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  avatar:
                      const Icon(Icons.video_camera_back), // Common media icon
                  deleteIcon: const Icon(Icons.cancel, color: Colors.red),
                  onDeleted: () => _removeMedia(index),
                );
              }),
            ),
          )
        : const SizedBox();
  }

  ///  Dropdown for Alert Status
  Widget _buildAlertDropdown() {
    return Row(
      children: [
        const Text(
          "Alert Status:  ",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButton<String>(
            value: selectedAlertStatus,
            dropdownColor: Colors.white,
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedAlertStatus = newValue!;
              });
            },
            items: ["Low", "Medium", "High"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  ///  Post to Community Button
  Widget _buildPostButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _postToCommunity,
        style: _buttonStyle(),
        child: const Text(
          "Post to Community",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Button Style
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
