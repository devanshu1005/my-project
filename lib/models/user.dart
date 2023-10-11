import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String username;
  final String bio;
  final String uid;

  const UserData({
    required this.email,
    required this.uid,
    required this.bio,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "bio": bio,
  };

  static UserData fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
      email: snapshot['email']??'',
      username: snapshot['username']??'',
      uid:  snapshot['uid']??'',
      bio: snapshot['bio']??'',
    );
  }
}