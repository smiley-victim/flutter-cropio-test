// import 'package:flutter/material.dart';
// import 'package:myapp/Features/Community/Data/Models/post_model.dart';
// import 'package:myapp/Features/Community/Data/community_services.dart';
// import 'package:myapp/Features/Community/Presentation/Pages/create_post_screen.dart';
// import 'package:myapp/Features/Community/Presentation/Widgets/custom_appbar.dart';
// import 'package:myapp/Features/Community/Presentation/Widgets/post_container.dart';

// class CommunityScreen extends StatefulWidget {
//   const CommunityScreen({super.key});

//   @override
//   State<CommunityScreen> createState() => _CommunityScreenState();
// }

// class _CommunityScreenState extends State<CommunityScreen> {
//   Future<void> getAllPosts() async {
//     posts = await CommunityMethods().getAllPost();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getAllPosts();
//     super.initState();
//   }

//   List<PostModel> posts = [
//     // PostModel(
//     //     postId: "...",
//     //     userId: "...",
//     //     content: "Check out my new tomato plants! #gardening #organic",
//     //     hashtags: ["gardening", "organic"],
//     //     mediaUrls: [
//     //       "...",
//     //       "...",
//     //       "...",
//     //       "...",
//     //     ],
//     //     createdAt: DateTime.parse("2025-03-06T16:58:08.547000Z"),
//     //     updatedAt: DateTime.parse("2025-03-06T16:58:08.547000Z"),
//     //     likesCount: 1,
//     //     commentsCount: 0,
//     //     alertStatus: "low",
//     //     userInfo: UserInfo(
//     //         username: "pravaskumarh@cropio",
//     //         fullName: "Haraprasad",
//     //         avatar:
//     //             "..."),
//     //     likedByUser: false,
//     //     comments: [])
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(245, 246, 247, 1),
//       // Remove the CustomAppbar here, we'll use SliverAppBar in CustomScrollView
//       body: RefreshIndicator(
//         onRefresh: getAllPosts,
//         child: CustomScrollView(
//           slivers: <Widget>[
//             CustomSliverAppBar.customSliverAppBar(),
//             // Add the list of posts as a SliverList
//             posts.isNotEmpty
//                 ? SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) {
//                         return PostContainer(post: posts[index]);
//                       },
//                       childCount: posts.length,
//                     ),
//                   )
//                 : SliverFillRemaining(
//                     // To center the CircularProgressIndicator when no posts
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => const CreatePostScreen()));
//         },
//         label: const Icon(
//           Icons.edit,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:myapp/Features/Community/Data/Models/post_model.dart';
import 'package:myapp/Features/Community/Data/community_services.dart';
import 'package:myapp/Features/Community/Presentation/Pages/create_post_screen.dart';
import 'package:myapp/Features/Community/Presentation/Widgets/post_container.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isLoading = true;
  bool isSearched = false;
  bool isSearchedLoading = false;
  List<PostModel> posts = [];
  List<PostModel> searchPosts = [];

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> getAllPosts() async {
    posts = await CommunityMethods().getAllPost();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getSearchPosts(String search) async {
    if (search.isNotEmpty) {
      setState(() {
        isSearchedLoading = true;
      });

      searchPosts = search.contains('#')
          ? await CommunityMethods().getPostByHashtag(search.trim())
          : await CommunityMethods().getPostBySearch(search.trim());

      setState(() {
        isSearchedLoading = false;
      });
    }
  }

  void _cancelSearch() {
    setState(() {
      isSearched = false;
      _searchController.clear();
    });
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    getAllPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: RefreshIndicator( // Wrap the entire body in RefreshIndicator
        onRefresh: () async {
          if (isSearched) {
            await getSearchPosts(_searchController.text.trim());
          } else {
            await getAllPosts();
          }
        },
        child: CustomScrollView( // Use CustomScrollView to incorporate SliverAppBar
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              forceMaterialTransparency: true,
              backgroundColor: Colors.white, // Or Colors.transparent if you want it to blend with the content
              surfaceTintColor: Colors.white,
              elevation: 0, 
              pinned: false, 
              floating: false, 
              snap: false,      
              expandedHeight: 130.0, 
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 86), // Adjust padding for the title
                title: const Text(
                  "Community",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                background: Container(
                  padding: const EdgeInsets.only(top: kToolbarHeight + 9, left: 20, right: 20), // Add padding for the search bar and top spacing
                  alignment: Alignment.bottomCenter, // Align the search bar to the bottom
                  child: Container(
                    color: Colors.white, 
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _searchController,
                              enabled: !isSearched,
                              decoration: const InputDecoration(
                                hintText: 'Search plants, diseases, or tags',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () {
                            if (isSearched) {
                              _cancelSearch();
                            } else if (_searchController.text.trim().isNotEmpty) {
                              setState(() {
                                isSearched = true;
                                getSearchPosts(_searchController.text.trim());
                              });
                            }
                          },
                          child: Icon(
                            isSearched ? Icons.cancel_outlined : Icons.search,
                            size: 35,
                            color: isSearched ? Colors.redAccent : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
            SliverList( // Use SliverList to display the posts
              delegate: SliverChildListDelegate([
                isLoading
                    ? const Center(child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator(),
                    ))
                    : posts.isEmpty && !isSearched && !isSearchedLoading // Handle empty state for initial load
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                "No posts are available",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : Container(), // Empty container to avoid errors when posts are loaded. Posts are handled in the ListView builder below.
                if (isSearched) // Conditional rendering for searched posts
                  isSearchedLoading
                      ? const Center(child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CircularProgressIndicator(),
                      ))
                      : searchPosts.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "No posts found for this search",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling as CustomScrollView handles it
                              shrinkWrap: true, // Important to use ListView inside SliverList
                              itemCount: searchPosts.length,
                              itemBuilder: (context, index) {
                                return PostContainer(post: searchPosts[index]);
                              },
                            )
                else if (!isLoading && posts.isNotEmpty) // Render posts when not loading and posts are available and not in search mode
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), // Disable ListView's scrolling
                    shrinkWrap: true, // Important to use ListView inside SliverList
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostContainer(post: posts[index]);
                    },
                  ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const CreatePostScreen()));
        },
        label: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}