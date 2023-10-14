class Comment {
  // final String username;

  final String uid;
  final String comment;

  const Comment({
    //required this.username,

    required this.uid,
    required this.comment,
  });

  static Comment fromSnap(Map<String, dynamic> data) {
    return Comment(
      uid: data['uid'] ?? '',
      comment: data['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        //"username": username,

        "uid": uid,
        "text": comment,
      };
}
