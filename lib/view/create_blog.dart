//import 'dart:html';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:blog_app/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;
  CrudMethods crudMethods = new CrudMethods();
  File selectedImage;
  bool load = false;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        load = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('blogImage')
          .child('${randomAlphaNumeric(9)}.jpg');
      final UploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl = await (await task.whenComplete(() => print('done')))
          .ref
          .getDownloadURL();
      print('downloadUrl is :$downloadUrl');
      Map<String, dynamic> blogData = {
        'imgUrl': downloadUrl,
        'author': authorController.text,
        'title': titleController.text,
        'desc': descController.text,
      };
      crudMethods.addData(blogData).then((value) {
        setState(() {
          load = false;
        });
      });
      Navigator.of(context).pop();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          GestureDetector(
              onTap: () {
                uploadBlog();
              },
              child: Icon(Icons.file_upload)),
        ],
      ),
      body: load
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              child: Image.file(
                                selectedImage,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Author name',
                                        border: InputBorder.none,
                                      ),
                                      controller: authorController,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    TextField(
                                        decoration: InputDecoration(
                                          hintText: 'title',
                                          border: InputBorder.none,
                                        ),
                                        controller: titleController),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 600.0,
                                child: TextField(
                                    //  expands: true,
                                    minLines: null,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: null,
                                    decoration: InputDecoration(
                                      hintText: 'body',
                                      border: InputBorder.none,
                                    ),
                                    controller: descController),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      backgroundColor: Color(0xff19151D),
    );
  }
}
