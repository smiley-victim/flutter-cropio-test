import 'dart:developer';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Community/Data/Models/comment_model.dart';
import 'package:myapp/Features/Community/Data/community_services.dart';
import 'package:readmore/readmore.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key, required this.postId});
  final String postId;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  bool isTap = false;
  bool isLoading = true;
  bool hasError = false;
  bool canComment = true;
  List<CommentModel> commentsList = [];

  Future<void> getComments() async {
    try {
      commentsList = await CommunityMethods().getAllComents(widget.postId);
      isLoading = false;
      hasError = false;
      setState(() {});
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  void initState() {
    getComments();
    super.initState();
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {

      if (!canComment || _commentController.text.isEmpty) return;
      String comment = _commentController.text;
      setState(() {
        canComment = false;
        commentsList.insert(
            0,
            CommentModel(
                commentId: "commentId",
                postId: "postId",
                userId: "userId",
                content: _commentController.text,
                createdAt: DateTime.now(),
                userInfo: UserInfo(
                    avatar: "null",
                    username: "pravaskumarh@cropio",
                    fullName: "Haraprasad")));

        _commentController.clear();
      });

      // Start 5-second cooldown timer
    Timer(Duration(seconds: 5), () {
      setState(() {
        canComment = true;
      });
    });

     // Send API request in background
    try {
      await CommunityMethods().addComment(
        widget.postId,
        comment,
      );
    }catch (e) {
      log("Failed to post comment: $e");
    }
      
    }
  }

  Widget profileImage({String? imgUrl}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: imgUrl != null
          ? CachedNetworkImage( imageUrl: imgUrl, width: 40, height: 40, fit: BoxFit.cover, )
          : Icon(Icons.person, size: 35),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(245, 246, 247, 1),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[600],
            ),
          ),
          const Text(
            "Comments",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 15),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : hasError
                  ? Center(
                      child: Text("Error loading chats",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                              color: Colors.red)))
                  : commentsList.isEmpty
                      ? Center(
                          child: Text("No Comments exists",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  color: Colors.grey)))
                      : SizedBox(
                          height: MediaQuery.sizeOf(context).height / 2.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: commentsList.length,
                            itemBuilder: (context, index) {
                              final comment = commentsList[index];
                              log(commentsList[index].content);

                              return ListTile(
                                leading: profileImage(imgUrl: comment.userInfo.avatar),
                                // leading: profileImage(imgUrl: comment.userInfo.avatar),

                                title: Text(
                                  comment.userInfo.username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: ReadMoreText(
                                    comment.content,
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.grey,
                                    trimCollapsedText: '...more',
                                    trimExpandedText: '...less',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                profileImage(imgUrl: null),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                    onTap: () => setState(() => isTap = true),
                  ),
                ),
                isTap
                    ? GestureDetector(
                        onTap: canComment ? _addComment : null,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: canComment ? Colors.black : Colors.grey,
                          ),
                          child: const Icon(Icons.arrow_upward,
                              color: Colors.white),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}