import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String username;
  final String postUrl;
  final String postId;
  final String uid;

  const Post({
    required this.description,
    required this.username,
    required this.postUrl,
    required this.postId,
    required this.uid,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
      postId: snapshot['postId'],
      uid: snapshot["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "username": username,
        'postUrl': postUrl,
        "postId": postId,
        "uid": uid,
      };
}
