

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/firestore_methods.dart';
import 'package:my_project/widgets/comment_card.dart';
import 'package:my_project/models/comment.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final List<Comment> lstComments;
  const CommentScreen({
    Key? key,
    required this.lstComments,
    required this.postId,
  }) : super(key: key);
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
 final TextEditingController _comController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('comments'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(), 
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic >>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => CommentCard(
              comment: Comment.fromSnap(snapshot.data!.docs[index].data()),
            ),
          
          );
        },
        ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _comController,
                decoration: const InputDecoration(
                  hintText: '    comment here',
                ),
              ),
            ),
           IconButton(
  onPressed: () async {
    final userProvider = UserProvider();
    if (userProvider.userdata != null) {
      final userId = userProvider.userdata!.uid;
      await FirestoreMethods().addCommentToPost(widget.postId, userId, _comController.text);
    } else {
      print('userdata is null');
    }
  }, icon: const Icon(Icons.send))
          ],
        )),
        );
  }
}