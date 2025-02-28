// Suggested code may be subject to a license. Learn more: ~LicenseLog:1578406221.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3458593050.

import 'package:flutter/material.dart';
import 'package:myapp/Features/Community/Presentation/Pages/create_post_screen.dart';

import '../../Data/Models/post_model.dart';
import '../Widgets/post_container.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});

  final List<PostModel> posts = [
    PostModel(
      userName: "Alice Smith",
      userImage: "https://picsum.photos/200/301",
      isVerified: true,
      postText: "Hello world! This is my first post.",
      imageUrls: ["https://picsum.photos/201", "https://picsum.photos/202"],
      likeCount: 15,
    ),
    PostModel(
      userName: "Bob Johnson",
      userImage: "https://picsum.photos/200/302",
      isVerified: false,
      postText: "Check out these amazing photos!",
      imageUrls: [
        "https://picsum.photos/203",
        "https://picsum.photos/204",
        "https://picsum.photos/205"
      ],
      likeCount: 27,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PostCreationPage()));
            },
            icon: Icon(Icons.add),
            tooltip: 'Add Post',
          )
        ],
        centerTitle: true,
        title: const Text('Community'),
      ),
      body: ListView.builder(
        itemCount: posts.length, // Number of posts you want to show
        itemBuilder: (context, index) => PostContainer(
          post: posts[index],
        ),
      ),
    );
  }
}
