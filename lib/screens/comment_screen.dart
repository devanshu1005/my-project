import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/firestore_methods.dart';
import 'package:my_project/widgets/comment_card.dart';
import 'package:my_project/models/comment.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _comController = TextEditingController();
  List<Comment> comments = [];
  bool isLoading = false;

  Future<List<Comment>> fetchCommentsForPost(String postId) async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> postSnapshot =
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get();
      if (postSnapshot.exists) {
        List<dynamic> commentsData = postSnapshot.data()!['comments'];

        if (commentsData != null) {
          for (var commentData in commentsData) {
            comments.add(Comment.fromSnap(commentData));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching comments: $e");
    }

    return comments;
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCommentsForPost(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) => CommentCard(postId: widget.postId,
                comment: comments[index],
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _comController,
                decoration: const InputDecoration(
                  hintText: 'Comment here',
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (userProvider.userdata != null) {
                  final userId = userProvider.userdata!.uid;
                  final username = userProvider.userdata!.username;
                  await FirestoreMethods().addCommentToPost(
                      widget.postId, userId, _comController.text, username);
                } else {
                  print('User data is null');
                }
              },
              icon: Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
