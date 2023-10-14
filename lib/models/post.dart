import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/models/comment.dart';

class Post {
  final String description;
  final String username;
  final String postUrl;
  final String postId;
  final String uid;
  final List<String> lstLikes;
  final List<Comment> lstComments;

  const Post({
    required this.description,
    required this.username,
    required this.postUrl,
    required this.postId,
    required this.uid,
    required this.lstLikes,
    required this.lstComments,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>;
    
    List<Comment> comments = [];
    if (data["comments"] != null) {
      for (var commentData in data["comments"] as List<dynamic>) {
        Comment comment = Comment.fromSnap(commentData as Map<String, dynamic>);
        comments.add(comment);
      }
    }

    return Post(
      description: data["description"],
      username: data["username"],
      postUrl: data['postUrl'],
      postId: data['postId'],
      uid: data["uid"],
      lstLikes: List<String>.from(data["likes"]),
      lstComments: comments,
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "username": username,
        'postUrl': postUrl,
        "postId": postId,
        "uid": uid,
        "likes": lstLikes,
        "comments": lstComments.map((comment) => comment.toJson()).toList(),
      };
}
