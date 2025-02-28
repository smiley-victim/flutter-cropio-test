
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:like_button/like_button.dart';

// class PostContainer extends StatelessWidget {
//   const PostContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(
//           children: [
//             CircleAvatar(
//                 backgroundColor: Colors.grey.shade500,
//                 backgroundImage: const NetworkImage(
//                     'https://picsum.photos/200/300'),
//                 radius: 17),
            
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "John Doe",
//                   overflow: TextOverflow.ellipsis,
//                   style: GoogleFonts.inter(
//                       fontSize: 15, fontWeight: FontWeight.w700),
//                 )),
//             Container(
//               width: 20,
//               height: 20,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     isAntiAlias: true,
//                     image: AssetImage("assets/images/verify.png"),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             const Spacer(),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.more_vert))
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 50),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "This is a sample post text that demonstrates how the post container looks like. It can contain multiple lines of text and will show ellipsis after 6 lines.",
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 6,
//                 textAlign: TextAlign.left,
//                 style: GoogleFonts.inter(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 selectionColor: Theme.of(context).indicatorColor,
//               ),
              
            
//               GridView.builder(
//                   primary: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 4, 
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisExtent: 100,
//                       crossAxisSpacing: 2,
//                       mainAxisSpacing: 5,
//                       childAspectRatio: 1),
//                   itemBuilder: (context, index) {
//                     return Hero(
//                       tag: 'image$index',
//                       child: GestureDetector(
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ImageScreen(
//                                     image: 'https://picsum.photos/200${index + 1}'))),
//                         child: Container(
//                           width: 100,
//                           height: 200,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                     'https://picsum.photos/200${index + 1}'),
//                                 fit: BoxFit.cover,
//                               ),
//                               color: Colors.grey.shade400),
//                         ),
//                       ),
//                     );
//                   })
//             ],
//           ),
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             LikeButton(
//                 onTap: (isLiked) async {
//                   return !isLiked;
//                 },
//                 circleColor:
//                     const CircleColor(start: Colors.blue, end: Colors.red),
//                 size: 25,
//                 likeBuilder: (isLiked) {
//                   return Icon(Icons.favorite,
//                       color: isLiked ? Colors.red : Colors.grey, size: 25);
//                 },
//                 likeCount: 42,
//                 likeCountAnimationType: LikeCountAnimationType.all,
//                 likeCountPadding: const EdgeInsets.all(10),
//                 bubblesColor: const BubblesColor(
//                     dotPrimaryColor: Colors.deepPurpleAccent,
//                     dotSecondaryColor: Colors.teal)),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.comment_outlined,
//                   size: 18,
//                 )),
//             IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.share_rounded,
//                   size: 18,
//                 )),
//           ],
//         )
//       ]),
//     );
//   }
// }

// class ImageScreen extends StatelessWidget {
//   final String image;
//   const ImageScreen({super.key, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Hero(
//               tag: 'image',
//               child: Expanded(
//                   child: InteractiveViewer(
//                       trackpadScrollCausesScale: true,
//                       panEnabled: true,
//                       scaleEnabled: true,
//                       minScale: 0.1,
//                       maxScale: 5,
//                       child: Image.network(image)))),
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import '../../Data/Models/post_model.dart';



class PostContainer extends StatelessWidget {
  final PostModel post;
  
  const PostContainer({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey.shade500,
                backgroundImage: NetworkImage(post.userImage),
                radius: 17),
            
            TextButton(
                onPressed: () {},
                child: Text(
                  post.userName,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w700),
                )),
            Offstage(
              offstage: !post.isVerified,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      isAntiAlias: true,
                      image: AssetImage("assets/images/verify.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.postText,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                selectionColor: Theme.of(context).indicatorColor,
              ),
              
              Offstage(
                offstage: post.imageUrls.isEmpty,
                child: GridView.builder(
                    primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: post.imageUrls.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: post.imageUrls.length == 1 ? 1 : 2,
                        mainAxisExtent: post.imageUrls.length == 1 ? 200 : 100,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1),
                    itemBuilder: (context, index) {
                      return Hero(
                        tag: 'image${post.imageUrls[index]}',
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageScreen(
                                      image: post.imageUrls[index]))),
                          child: Container(
                            width: 100,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    post.imageUrls.length == 1 ? 20 : 10),
                                image: DecorationImage(
                                  image: NetworkImage(post.imageUrls[index]),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.grey.shade400),
                          ),
                        ),
                      );
                    }))
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LikeButton(
                onTap: (isLiked) async {
                  return !isLiked;
                },
                circleColor:
                    const CircleColor(start: Colors.blue, end: Colors.red),
                size: 25,
                likeBuilder: (isLiked) {
                  return Icon(Icons.favorite,
                      color: isLiked ? Colors.red : Colors.grey, size: 25);
                },
                likeCount: post.likeCount,
                likeCountAnimationType: LikeCountAnimationType.all,
                likeCountPadding: const EdgeInsets.all(10),
                bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.deepPurpleAccent,
                    dotSecondaryColor: Colors.teal)),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  size: 18,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_rounded,
                  size: 18,
                )),
          ],
        )
      ]),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String image;
  const ImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actionsIconTheme: const IconThemeData(color: Colors.amber),
        title: const Text('Image', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
              tag: 'image$image',
              child: Expanded(
                  child: InteractiveViewer(
                      trackpadScrollCausesScale: true,
                      panEnabled: true,
                      scaleEnabled: true,
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.network(image)))),
        ],
      ),
    );
  }
}

