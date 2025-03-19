
import 'dart:convert';

import 'package:myapp/Features/Community/Data/Models/comment_model.dart';

PostModel singlePostFromJson(String str) =>
    PostModel.fromJson(json.decode(str));

List<PostModel> postModelFromJson(String str) =>
    List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

class PostModel {
  String postId;
  String userId;
  String content;
  List<String> hashtags;
  List<String> mediaUrls;
  DateTime createdAt;
  DateTime updatedAt;
  int likesCount;
  int commentsCount;
  String alertStatus;
  String plantName;
  String question;
  String description;
  String location;
  UserInfo userInfo;
  List<CommentModel> comments;

  bool likedByUser;

  PostModel({
    required this.postId,
    required this.userId,
    required this.content,
    required this.hashtags,
    required this.mediaUrls,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.alertStatus,
    required this.plantName,
    required this.question,
    required this.description,
    required this.location,
    required this.userInfo,
    required this.likedByUser,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["post_id"],
        userId: json["user_id"],
        content: json["content"],
        hashtags: List<String>.from(json["hashtags"].map((x) => x)),
        mediaUrls: List<String>.from(json["media_urls"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
        alertStatus: json["alertStatus"],
        plantName: json["plant_name"],
        question: json["question"],
        description: json["description"],
        location: json["location"],
        comments: json["comments"] ?? [],
        userInfo: UserInfo.fromJson(json["user_info"]),
        likedByUser: json["liked_by_user"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "user_id": userId,
        "content": content,
        "hashtags": List<dynamic>.from(hashtags.map((x) => x)),
        "media_urls": List<dynamic>.from(mediaUrls.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "likes_count": likesCount,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "comments_count": commentsCount,
        "alertStatus": alertStatus,
        "plant_name": plantName,
        "question": question,
        "description": description,
        "location": location,
        "user_info": userInfo.toJson(),
        "liked_by_user": likedByUser,
      };
}

class UserInfo {
  String username;
  String fullName;
  String avatar;

  UserInfo({
    required this.username,
    required this.fullName,
    required this.avatar,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        username: json["username"],
        fullName: json["full_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": fullName,
        "avatar": avatar,
      };
}
