import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/models/reply.dart';

class Comment {
  final String username;
  final String uid;
  final String comment;
  final String commentId;
  final List<Reply> lstReplies;

  const Comment({
    required this.uid,
    required this.comment,
    required this.username,
    required this.commentId,
    required this.lstReplies,
  });

  static Comment fromSnap(Map<String, dynamic> data) {
   //var data = snap.data() as Map<String, dynamic>;
    
    List<Reply> replies = [];
    if (data["replies"] != null) {
      for (var replydata in data["replies"] as List<dynamic>) {
        Reply reply = Reply.fromSnap(replydata);
        replies.add(reply);
      }
    }

    return Comment(
      uid: data['uid'] ?? '',
      comment: data['text'] ?? '',
      username: data['username'] ?? '',
      commentId: data['commentId']??'',
      lstReplies: replies, 
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "text": comment,
        "commentId": commentId,
        "replies": lstReplies.map((comment) => comment.toJson()).toList(),
      };
}
