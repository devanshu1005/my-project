import 'package:my_project/models/comment.dart';

class Reply {
  final String username;
  final String replies;

  const Reply({
    required this.username,
    required this.replies,
  });

  static Reply fromSnap(Map<String, dynamic> data) {
    // var data = snap.data() as Map<String, dynamic>;
    return Reply(
      username: data['name']?? '',
      replies: data['reply']??'',
    );
  }

  Map<String, dynamic> toJson() => {
        "name": username,
        "reply": replies,
      };
}
