import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/providers/user_provider.dart';
import 'package:my_project/resources/firestore_methods.dart';
import 'package:my_project/screens/feed_screen.dart';
import 'package:my_project/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? file;
  bool isLoading = false;

  void uploadImage(String uid, String username) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        descriptionController.text,
        file!,
        uid,
        username,
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FeedScreen();
              }));
        });
        showSnackBar('posted', context);
        clearImage();
      } else {
        setState(() {
          isLoading = false;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FeedScreen();
              }));
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a photo'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List pickedFile = await pickImage(ImageSource.camera);
                setState(() {
                  file = pickedFile;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List pickedFile = await pickImage(ImageSource.gallery);
                setState(() {
                  file = pickedFile;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void clearImage(){
    setState(() {
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        actions: [
          TextButton(
            onPressed: () => uploadImage(userProvider.userdata!.uid, userProvider.userdata!.username),
            child: const Text('Post'),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : file == null
              ? Center(
                  child: IconButton(
                    onPressed: () => _selectImage(context),
                    icon: const Icon(Icons.upload),
                  ),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              hintText: 'Enter description here',
                              labelText: 'Description',
                            ),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                               image: MemoryImage(file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                                ),
                              ),
                            ),
                          ),
                        
                      ],
                    )
                  ],
                ),
    );
  }
}
