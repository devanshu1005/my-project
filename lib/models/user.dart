import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String bio;
  final String uid;

  const User({
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

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email']??'',
      username: snapshot['username']??'',
      uid:  snapshot['uid']??'',
      bio: snapshot['bio']??'',
    );
  }
}