
import 'package:flutter/material.dart';
import 'package:my_project/models/comment.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);
  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(
          children: [
        //   TextSpan(
        //   text: widget.comment.uid,
        //   style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        
        // ),
        TextSpan(
          text: widget.comment.comment,
          style: const TextStyle(fontWeight: FontWeight.w400,color: Colors.black38),
        ),
        // TextSpan(
        //   text: widget.comment.postId,
        //   style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black38),
        // ),
          ],
        )
        )
      ],
    ),
    );
  }
}