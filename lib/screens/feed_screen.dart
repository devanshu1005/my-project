import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/post.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/auth_methods.dart';
import 'package:my_project/screens/add_post_screen.dart';
import 'package:my_project/screens/login_screen.dart';
import 'package:my_project/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
  
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);


  return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to My Project'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthMethods().signOut();
                if (context.mounted) {
                  Navigator.of(context)
                      .pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen(),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.logout)),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddPostScreen();
              }));
              // })).then((value) {
              //   if (value) {
              //     fetchPostsData();
              //   }
              // });
            },
            icon: const Icon(Icons.add),
          )
        ],
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
            itemBuilder: (context, index) => PostCard(
              post: Post.fromSnap(snapshot.data!.docs[index]),
            ),
          
          );
        },
        ),
    );
    
  }
}





   