import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/Features/Community/Data/Models/comment_model.dart';
import 'package:myapp/Features/Community/Data/Models/post_model.dart';

abstract class CommunityServices {
  Future<List<PostModel>> getAllPost();
  Future<List<PostModel>> getPostByHashtag(String hashtag);
  Future<List<PostModel>> getPostBySearch(String hashtag);
  Future<List<CommentModel>> getAllComents(String postID);
  Future<String> createPost(
      {required String plantName,
      required String alertStatus,
      required String question,
      String? description,
      String? hashtags,
      List<File>? media});
  Future<String> addComment(String postid, String comment);
  Future<void> likePost(String postid);
  Future<void> unLikePost(String postid);
}

class CommunityMethods extends CommunityServices {
  final String baseUrl = 'https://beta-api.cropio.in/';
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQzODcyMDQ1LCJpYXQiOjE3NDEyODAwNDUsImp0aSI6IjUyNGVjNWQ5Nzg2ZTRjZDY4MGZhMTE1YzY2YzQ2NjA0IiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.ruHmO3B9XpLeGKCc2exZTPZeYzd1fkQsRWtsp8edA5I';

  @override
  Future<List<PostModel>> getAllPost() async {
    try {
      final url =
          Uri.parse('${baseUrl}community/posts/?limit=20'); // Construct URL
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      /// API Call

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final List<PostModel> allData = postModelFromJson(response.body);
        log(allData.toString());

        /// Return processed data
        return allData;
      } else {
        throw Exception("Failed to all posts: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching all posts: $e");
      return []; // Return empty list in case of failure
    }
  }

  @override
Future<List<PostModel>> getPostByHashtag(String hashtag) async {
  try {
    // Encode the hashtag to ensure special characters are correctly handled
    final url = Uri.parse('$baseUrl/community/posts/')
        .replace(queryParameters: {
      'hashtag': hashtag, // Query Parameter
      'limit': '30', // Adjust limit as needed
      'skip': '0' // Ensure proper pagination
    });

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    log("${response.statusCode}");

    if (response.statusCode == 200) {
      final List<PostModel> allData = postModelFromJson(response.body);
      log(allData.toString());
      return allData;
    } else {
      throw Exception("Failed to load posts: ${response.statusCode}");
    }
  } catch (e) {
    log("Error fetching posts: $e");
    return []; // Return empty list in case of failure
  }
}


  @override
  Future<List<PostModel>> getPostBySearch(String keyword) async {
    try {
      final url = Uri.parse(
          '${baseUrl}community/posts/?search=$keyword&limit=30&skip=0'); // Construct URL
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      /// API Call

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final List<PostModel> allData = postModelFromJson(response.body);
        log(allData.toString());

        /// Return processed data
        return allData;
      } else {
        throw Exception("Failed to load posts: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching  posts: $e");
      return []; // Return empty list in case of failure
    }
  }

  @override
  Future<List<CommentModel>> getAllComents(String postID) async {
    try {
      final url = Uri.parse(
          '${baseUrl}community/posts/$postID/comments/?limit=50'); // Construct URL
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      /// API Call

      log("${response.statusCode}");

      if (response.statusCode == 200) {
        final List<CommentModel> commentData =
            commentModelFromJson(response.body);

        /// Return processed data
        return commentData;
      } else {
        throw Exception("Failed to load Comments: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching  posts: $e");
      return []; // Return empty list in case of failure
    }
  }

  @override
  Future<String> createPost(
      {required String plantName,
      required String alertStatus,
      required String question,
      String? description,
      String? hashtags,
      List<File>? media}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse('${baseUrl}community/posts/'));

      // Adding fields as form-data
      request.headers['Authorization'] =
          "Bearer $token"; //  Add Authorization Header
      request.fields['plant_name'] = plantName;
      request.fields['question'] = question;
      request.fields['location'] = "India";
      //request.fields['hashtags'] = hashtags!;
      log(hashtags!);

      // ✅ Convert List<File> to List<http.MultipartFile> and add to request
      if (media != null && media.isNotEmpty) {
        for (File file in media) {
          request.files.add(await http.MultipartFile.fromPath(
            'media', // Field name expected by the API
            file.path,
          ));
        }
      }

      if (description != null && description.isNotEmpty) {
        request.fields['description'] = description;
      }
      if (hashtags != null && hashtags.isNotEmpty) {
        request.fields['hashtags'] = hashtags;
      }
      log("Final Request Fields: ${request.fields}");
      // Sending the request
      var streamedResponse = await request.send();

      // Convert streamedResponse to a regular Response
      var response = await http.Response.fromStream(streamedResponse);

      log("${response.statusCode}");

      if (response.statusCode == 201) {
        final PostModel postData = singlePostFromJson(response.body);
        log("Post added : ${response.statusCode}");

        try {
          final url =
              Uri.parse('${baseUrl}community/posts/${postData.postId}/');
          final resp = await http.put(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: json.encode({
              "alertStatus":
                  alertStatus.toLowerCase(), // Sending data in JSON format
            }),
          );
          log("Alert status= $alertStatus: ${resp.statusCode} : ${resp.body}");
          if (resp.statusCode == 200) {
            return "success";
          } else {
            throw Exception(
                "Failed to update alert-status: ${response.statusCode}");
          }
        } catch (error) {
          return "Failed to update status: $error";
        }
      } else {
        throw Exception("Failed to create post: ${response.statusCode}");
      }
    } catch (e) {
      log("Error while adding  posts: $e");
      return "Error while adding  posts: $e"; // Return empty list in case of failure
    }
  }

  @override
  Future<String> addComment(String postid, String comment) async {
    try {
      final url = Uri.parse('${baseUrl}community/posts/$postid/comments/');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "content": comment, // Sending data in JSON format
        }),
      );

      log("${response.statusCode}");

      if (response.statusCode == 201) {
        /// Return processed data
        log("Comment has been added : ${response.statusCode}");
        return "Comment has been added";
      } else {
        throw Exception("Failed to load comment: ${response.body}");
      }
    } catch (e) {
      log("Error fetching comments: $e");
      return "Error fetching comments: $e"; // Return empty list in case of failure
    }
  }

  @override
  Future<void> likePost(String postid) async {
    try {
      final url = Uri.parse('${baseUrl}community/posts/$postid/like/');
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        /// Return processed data
        log("${response.statusCode}: ${response.body}");
      } else {
        throw Exception(
            "Failed to load :${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      log("Error : $e");
      // Return empty list in case of failure
    }
  }

  @override
  Future<void> unLikePost(String postid) async {
    try {
      final url = Uri.parse('${baseUrl}community/posts/$postid/like/');
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        /// Return processed data
        log("${response.statusCode}: ${response.body}");
      } else {
        throw Exception(
            "Failed to load :${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      log("Error : $e");
      // Return empty list in case of failure
    }
  }
}