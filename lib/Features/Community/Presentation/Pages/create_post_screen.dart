import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Core/Constants/appconstants.dart';

class PostCreationPage extends StatefulWidget {
  const PostCreationPage({super.key});

  @override
  State<PostCreationPage> createState() => _PostCreationPageState();
}

class _PostCreationPageState extends State<PostCreationPage> {
  final TextEditingController _postcontroller = TextEditingController();
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    _postcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<PostBloc, PostState>(
    // listener: (context, state) {
    //   /// here we can implement listener =>
    //   if (state is PostFailure) {

    //   }
    //   //
    //   //
    //   /// here we can implement listener =>
    //   if (state is PostSuccess) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text(
    //       "Posted Successfully",
    //      
    //     )));
    //     return Navigator.pop(context);
    //   }
    // },
    // builder: (context, state) {
    //final userid = context.watch<AuthBloc>().state as AuthSuccess;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Create Post',
          style: GoogleFonts.inter(fontSize: 20),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 83, 136, 222))),
              onPressed: () async {
                // context.read<PostBloc>().add(PostSendRequested(
                //           text: _postcontroller.text,
                //           image: images,
                //         ));
              },
              child: Text(
                'Send',
                style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
              )),
          s10,
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 79, 152).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 348,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color:const Color.fromARGB(255, 2, 97, 187).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: _postcontroller,
                          decoration: InputDecoration(
                            hintText: 'What\'s on your mind ?',
                            counterStyle:
                                GoogleFonts.inter(color: Colors.white),
                            hintStyle: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 1),
                            border: InputBorder.none,
                          ),
                          maxLines: 7,
                          maxLength: 100,
                          style: GoogleFonts.inter(
                              fontSize: 18, color: Colors.white),
                        ),
                        if (images.isNotEmpty)
                          Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: Colors.teal.shade400.withOpacity(0.5),
                              ),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return Image.file(
                                      images[index],
                                      fit: BoxFit.contain,
                                    );
                                  }))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            // images = await imagepicker();
                            // setState(() {});
                          },
                          icon: Icon(
                            Icons.image_outlined,
                            color: Colors.white.withOpacity(0.7),
                          )),
                      s10,
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white.withOpacity(0.7),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    // },
    // );
  }
}
