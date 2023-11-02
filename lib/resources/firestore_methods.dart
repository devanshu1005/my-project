import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
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
        lstLikes: [],
        lstComments: [],
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

  //liking the post

Future<void> likePost(String postId, String uid) async {
  try {
    final HttpsCallable likeCallable = FirebaseFunctions.instance.httpsCallable('likePost');

    final result = await likeCallable.call({
      'postId': postId,
      'uid': uid,
    });

    final data = result.data;

    if (data['result'] == 'success') {
      // Like operation was successful
      print('Like successful');
    } else {
      // Handle the error
      print('Error: ${data['message']}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the function call
    print('Error: $e');
  }
}

Future<void> dislikePost(String postId, String uid) async {
  try {
    final HttpsCallable dislikeCallable = FirebaseFunctions.instance.httpsCallable('dislikePost');

    final result = await dislikeCallable.call({
      'postId': postId,
      'uid': uid,
    });

    final data = result.data;

    if (data['result'] == 'success') {
      // Dislike operation was successful
      print('Dislike successful');
    } else {
      // Handle the error
      print('Error: ${data['message']}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the function call
    print('Error: $e');
  }
}



  // Update the 'addCommentToPost' method
Future<void> addAComment(String postId, String uid, String comment, String username) async {
  try {
    final HttpsCallable addCommentCallable = FirebaseFunctions.instance.httpsCallable('addAComment');

    final result = await addCommentCallable.call({
      'postId': postId,
      'uid': uid,
      'comment': comment,
      'username': username,
    });

    final data = result.data;

    if (data['result'] == 'success') {
      // Comment addition was successful
      print('Comment added successfully');
    } else {
      // Handle the error
      print('Error: ${data['message']}');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the function call
    print('Error: $e');
  }
}


// Update the 'addReplyToComment' method
Future<void> addReplyToComment(String postId, String commentId, String reply, String username) async {
  try {
    if (reply.isNotEmpty) {
      // Use the update method to add a reply to a comment's "replies" field as an array.
      await _firestore.collection('posts').doc(postId).update({
        'comments': FieldValue.arrayUnion([{
          'commentId': commentId,
          'replies': FieldValue.arrayUnion([{
            'text': reply,
            'username': username,
          }]),
        }]),
      });
    } else {
      print('Reply is empty');
    }
  } catch (e) {
    print(e.toString());
  }
}


}