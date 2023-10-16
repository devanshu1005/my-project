class Comment {
  final String username;
  final String uid;
  final String comment;
  final String commentId;
  

  const Comment({
    required this.uid,
    required this.comment,
    required this.username,
    required this.commentId,
  });

  static Comment fromSnap(Map<String, dynamic> data) {
    return Comment(
      uid: data['uid'] ?? '',
      comment: data['text'] ?? '',
      username: data['username'] ?? '',
      commentId: data['commentId']??'',
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "text": comment,
        "commentId": commentId,
      };
}
