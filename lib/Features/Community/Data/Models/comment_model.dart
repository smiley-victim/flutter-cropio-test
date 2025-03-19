// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
    String commentId;
    String postId;
    String userId;
    String content;
    DateTime createdAt;
    UserInfo userInfo;

    CommentModel({
        required this.commentId,
        required this.postId,
        required this.userId,
        required this.content,
        required this.createdAt,
        required this.userInfo,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json["comment_id"],
        postId: json["post_id"],
        userId: json["user_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        userInfo: UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "comment_id": commentId,
        "post_id": postId,
        "user_id": userId,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "user_info": userInfo.toJson(),
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
