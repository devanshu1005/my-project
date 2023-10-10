import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/auth_methods.dart';
import 'package:my_project/screens/add_post_screen.dart';
import 'package:my_project/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_project/models/user.dart' as model;

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
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

  return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to My Project'),
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
              icon: Icon(Icons.logout)),
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
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(child: Text('username')),
    );
    //   isLoading
    // ? Center(
    //     child: CircularProgressIndicator(),
    //   )
    // : ListView.builder(
    //     itemCount: listOfPosts.length,
    //     itemBuilder: (context, index) => PostCard(
    //       snap: listOfPosts[index].data(),
    //     ),
    //   ),
  }
}
