import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/models/user.dart' as model;


class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<model.UserData> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.UserData.fromSnap(snap);
  // }

  //signup user

 Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res= 'some error occurred';
    try{
      if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && bio.isNotEmpty){
        //register user
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       print(cred.user!.uid);

       //add user to our database
       model.UserData user = model.UserData(
         username: username,
         uid: cred.user!.uid,
         email: email,
         bio: bio,
       );

       await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
       res = "success";
      }
      }catch(err){
      res= err.toString();
    } 
    return res;
  }
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res= "some error occured";

    try{
   if(email.isNotEmpty && password.isNotEmpty){
   await _auth.signInWithEmailAndPassword(email: email, password: password);
   res = "success";
   }else {
    res= "please enter all the fields";
   }
    } catch(err){
   res= err.toString();
    }
    return res;
  }

  //signing out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}