import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/models/post.dart';
import 'package:my_project/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
  ) async {
    String res = "some error occured";
    try{
      String photoUrl =await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description, 
        username: username, 
        postUrl: photoUrl, 
        postId: postId,
        uid: uid,
        );

        _firestore.collection('posts').doc(postId).set(
          post.toJson(),
        );
        res = "success";
    }catch(err){
      res =err.toString();

    }
    return res;
  }
}