import 'package:flutter/material.dart';

/// here the user model which stores the user data send and received from the server

@immutable
class UserModel {
  final String name;
  final String profilePicture;
  final String userid;
  final String bannerPicture;
  final bool isPremium;
  final String email;
  // final List<String> posts;

  const UserModel({
    required this.name,
    required this.profilePicture,
    required this.userid,
    required this.bannerPicture,
    required this.isPremium,
    required this.email,
    // required this.posts,
  });

  UserModel copyWith({
    String? name,
    String? profilePicture,
    String? userid,
    String? bannerPicture,
    bool? isPremium,
    String? email,
    // List<String>? posts,
  }) {
    return UserModel(
      name: name ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      userid: userid ?? this.userid,
      bannerPicture: bannerPicture ?? this.bannerPicture,
      isPremium: isPremium ?? this.isPremium,
      email: email ?? this.email,
      // posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({"name": name});
    result.addAll({"profilePicture": profilePicture});
    result.addAll({"bannerPicture": bannerPicture});
    result.addAll({"isPremium": isPremium});
    result.addAll({"email": email});
    // result.addAll({"posts": posts});
    result.addAll({"userId": userid});
    return result;
  }
}


