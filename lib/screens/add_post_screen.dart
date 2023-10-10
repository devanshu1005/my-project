import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  Uint8List? file;

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
                // Navigator.pop(context);
                // Uint8List pickedFile = await pickImage(ImageSource.camera);
                // imageUrl =
                //     await uploadImageToStorage('posts', pickedFile, true);
                // setState(() {
                //   file = pickedFile;
                // });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                // Navigator.of(context).pop();
                // Uint8List pickedFile = await pickImage(ImageSource.gallery);
                // imageUrl =
                //     // await uploadImageToStorage('posts', pickedFile, true);

                // setState(() {
                //   file = pickedFile;
                // });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Upload Image'),
              actions: [
                TextButton(
                  onPressed: () {
                    // uploadPost(descriptionController.text, file!,
                    //     nameController.text, imageUrl);
                  },
                  child: const Text('Post'),
                ),
              ],
            ),
            body: file == null
                ? Center(
                    child: IconButton(
                      onPressed: () {}, // Use 'context' here
                      icon: Icon(Icons.upload),
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
                              decoration: InputDecoration(
                                  hintText: 'Enter description here',
                                  labelText: 'Description'),
                              maxLines: 8,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1696831387335-6faf0a63da01?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1206&q=80',
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          );
  }
}