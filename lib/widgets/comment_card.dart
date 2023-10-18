import 'package:flutter/material.dart';
import 'package:my_project/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/models/reply.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/firestore_methods.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final String postId;

  const CommentCard({
    Key? key,
    required this.comment,
    required this.postId,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final TextEditingController _replyController = TextEditingController();
  bool _showReplyField = false;
  List<Reply> replies = [];

  

// Function to fetch replies for a specific comment
Future<List<QueryDocumentSnapshot>> fetchRepliesForComment(String postId, String commentId) async {
  try {
    CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');
    DocumentReference postDoc = postCollection.doc(postId);
    CollectionReference commentsCollection = postDoc.collection('comments');
    DocumentReference commentDoc = commentsCollection.doc(commentId);
    CollectionReference repliesCollection = commentDoc.collection('replies');

    QuerySnapshot querySnapshot = await repliesCollection.get();
    return querySnapshot.docs;
  } catch (e) {
    print("Error fetching replies: $e");
    return [];
  }
}


  @override
  Widget build(BuildContext context) {

    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.comment.username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '    ${widget.comment.comment}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showReplyField = !_showReplyField;
                        });
                      },
                      icon: Icon(Icons.reply),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showReplyField)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: InputDecoration(
                      hintText: 'Type your reply...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: ()async {if (userProvider.userdata != null) {
                  final userId = userProvider.userdata!.uid;
                  final username = userProvider.userdata!.username;
                  await FirestoreMethods().addReplyToComment(
                     widget.postId , widget.comment.commentId, _replyController.text, username);
                } else {
                  print('User data is null');
                }
                    
                    // Implement your reply logic here
                    final replyText = _replyController.text;
                    // Do something with replyText
                    print(replyText);
                    _replyController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
