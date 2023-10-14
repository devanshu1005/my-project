import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/post.dart';
import 'package:my_project/resources/firestore_methods.dart';
import 'package:my_project/screens/comment_screen.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isliked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //Header section
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.post.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Delete',
                                ]
                                    .map((e) => InkWell(
                                          onTap: () async {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),

          //image section
          SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
           child:Image.network(
              widget.post.postUrl,
              fit: BoxFit.cover,
            ),

          ),

          //like comment section
          Row(
            children: [
              IconButton(
          onPressed: () async {
            // Call the likePost function when the 'like' button is pressed
            await FirestoreMethods().likePost(
              widget.post.postId,
              FirebaseAuth.instance.currentUser!.uid,
              widget.post.lstLikes,
            );

            setState(() {
              isliked = !isliked; 
            });
          },
          icon: Icon(
            isliked ? Icons.favorite : Icons.favorite_border,
            color: isliked ? Colors.red : Colors.black,
          ),
        ),
              IconButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CommentScreen(lstComments: widget.post.lstComments, postId: widget.post.postId,);
              }));
                },
                
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
              ))
            ],
          ),

          //description and no. of comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.post.lstLikes.length}likes',
                   style: const TextStyle(
                    fontWeight: FontWeight.bold
                   ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}