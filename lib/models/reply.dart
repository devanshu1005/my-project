import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/models/comment.dart';

class Reply {
  final String username;
  final List<Comment> replies;

  const Reply({
    required this.username,
    required this.replies,
  });

  static Reply fromSnap(DocumentSnapshot  snap) {
    var data = snap.data() as Map<String, dynamic>;
    return Reply(
      username: data['username']?? '',
      replies: data['replies']??'',
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "replies": replies,
      };
}
