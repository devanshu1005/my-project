
class Comment{
 // final String username;
  final String postId;
  final String uid;
  final String comment;

  const Comment({
    //required this.username,
    required this.postId,
    required this.uid,
    required this.comment,
  });

 static Comment fromSnap(Map<String, dynamic> data) {

  return Comment(
    postId: data['postId'] ?? '',
    uid: data['uid'] ?? '',
    comment: data['comment'] ?? '',
  );
}

Map<String, dynamic> toJson() => {
  //"username": username,
  "postId": postId,
  "uid": uid,
  "comment": comment,
};
}