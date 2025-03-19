// Suggested code may be subject to a license. Learn more: ~LicenseLog:2292166983.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:824852693.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1927496086.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3629586231.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3482894973.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2100720286.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4225948306.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3353609858.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Features/Community/Data/Models/post_model.dart';
import 'package:myapp/Features/Community/Data/community_services.dart';
import 'package:myapp/Features/Community/Presentation/Widgets/comment_section.dart';

class PostContainer extends StatefulWidget {
  final PostModel post;
  const PostContainer({super.key, required this.post});

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  bool isLikedPost = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    isLikedPost = widget.post.likedByUser;
    likeCount = widget.post.likesCount;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // USER INFO
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(widget.post.userInfo.avatar),
                  radius: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      widget.post.userInfo.fullName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  _formatTimestamp(widget.post.createdAt),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // PLANT NAME
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: Chip(
                label: Row(
                  spacing: 5.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.grass, size: 16, color: Colors.green),
                    Text(
                      widget.post.plantName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
          ),
          const SizedBox(height: 5),

          // QUESTION
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 15),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 251, 231, 231),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_mark,
                          size: 15,
                          color: Colors.red,
                        ),
                        Text(
                          "Question",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.post.question,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          // MEDIA GRID (IF ANY)
          if (widget.post.mediaUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: _buildMediaGrid(widget.post.mediaUrls),
            ),
          const SizedBox(height: 8),

          // ALERT STATUS & LOCATION
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 15, top: 8, bottom: 8),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text(
                      " ${widget.post.location}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "${widget.post.alertStatus[0].toUpperCase() + widget.post.alertStatus.substring(1)} Alert",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // DESCRIPTION
          (widget.post.description != "")
              ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 231, 235, 251),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.book,
                              size: 15,
                              color: Colors.blueAccent,
                            ),
                            Text(
                              "Description",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.post.description,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        // Expanded(
                        //   child: Text(
                        //     widget.post.description,
                        //     style: const TextStyle(
                        //       fontFamily: 'Poppins',
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.black87,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(left: 40, right: 15, bottom: 10),
            child: Wrap(
              spacing: 8, // Space between hashtags
              runSpacing: 6, // Space between lines
              children: widget.post.hashtags.map((tag) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20), // Smooth rounded edges
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    color: Colors.grey.shade200, // Background color
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // LIKE, COMMENT, SHARE BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(
                icon: Icons.favorite,
                label: likeCount.toString(),
                color: isLikedPost ? Colors.red : Colors.grey,
                onTap: _toggleLike,
              ),
              _buildIconButton(
                icon: Icons.comment,
                label: "Comment",
                onTap: _showCommentSection,
              ),
              _buildIconButton(
                icon: Icons.share,
                label: "Share",
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _toggleLike() async {
    if (isLikedPost) {
      setState(() {
        isLikedPost = false;
        likeCount--;
      });
      await CommunityMethods().unLikePost(widget.post.postId);
    } else {
      setState(() {
        isLikedPost = true;
        likeCount++;
      });
      await CommunityMethods().likePost(widget.post.postId);
    }
  }

  void _showCommentSection() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return CommentBottomSheet(postId: widget.post.postId);
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else {
      return '${timestamp.day} ${_getMonthName(timestamp.month)}';
    }
  }

  String _getMonthName(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][month - 1];
  }

  Widget _buildMediaGrid(List<String> media) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: media.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 100,
        crossAxisSpacing: 2,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return Hero(
          tag: 'image$index',
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageScreen(image: media[index]))),
            child: Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey
                    .shade400, // Background color for when image is loading or fails
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: media[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    child: Icon(Icons.error, color: Colors.red, size: 50),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.grey, size: 24),
          const SizedBox(width: 5),
          Text(label,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 14)),
        ],
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String image;
  const ImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Clamping the Error Widget's height
    double errorWidgetHeight = screenHeight * 0.5;
    double maxErrorHeight = 400.0;
    errorWidgetHeight = errorWidgetHeight > maxErrorHeight ? maxErrorHeight : errorWidgetHeight;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Media Viewer"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: 'image',
                child: InteractiveViewer(
                  trackpadScrollCausesScale: true,
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 0.1,
                  maxScale: 5,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      height: errorWidgetHeight, // Use the clamped height here
                      width: screenWidth,
                      color: Colors.grey.shade400,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 50),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              "Error While loading media , Please try again..",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
