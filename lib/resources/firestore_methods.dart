import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> likePost(String postId, String uid, List likes)async{
    try{
      if(likes.contains(uid)){
        await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid]),
        });
      }else{
         await _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid]),
        });
      }

    }catch(e){
      print(e.toString(),);
    }
  }

  Future<void> addCommentToPost(String postId, String uid, String comment) async {
  try {
    if (comment.isNotEmpty) {
      // Use the update method to add a comment to the "comments" field as an array.
      await _firestore.collection('posts').doc(postId).update({
        'comments': FieldValue.arrayUnion([{
          'text': comment,
          'uid': uid,
        }]),
      });
    } else {
      print('Comment is empty');
    }
  } catch (e) {
    print(e.toString());
  }
}

}