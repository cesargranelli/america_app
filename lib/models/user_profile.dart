import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String email;
  final List<String> roles;
  final DateTime createdAt;

  UserProfile({
    required this.uid,
    required this.email,
    required this.roles,
    required this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'] as String,
      email: data['email'] as String,
      roles: data['roles'] as List<String>,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'roles': roles,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
