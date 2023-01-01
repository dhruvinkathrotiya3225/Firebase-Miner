import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:author_registration/helpers/firestore_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../modals/global.dart';

class Add_Book extends StatefulWidget {
  const Add_Book({Key? key}) : super(key: key);

  @override
  State<Add_Book> createState() => _Add_BookState();
}

class _Add_BookState extends State<Add_Book> {
  final ImagePicker _picker = ImagePicker();
  File? image;
  XFile? pickedImage;
  String imagestring = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add Book"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: Global.insertdatakey,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height * 0.42,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: (image != null)
                                  ? FileImage(image!)
                                  : NetworkImage(
                                          "https://media.istockphoto.com/id/1306307586/photo/collection-of-old-books-in-library.jpg?b=1&s=170667a&w=0&k=20&c=qEyK-d-aFOds4EcAYWoBIKnO5ELCiSb1PZpW_WU8RZ4=")
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        // Positioned(
                        //   left: 200,
                        //   top: 270,
                        //   child: FloatingActionButton(
                        //     backgroundColor: Colors.white,
                        //     mini: true,
                        //     onPressed: showDailog,
                        //     child: const Icon(
                        //       Icons.add,
                        //       size: 20,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      controller: Global.Authornamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Author name",
                        label: Text("Name"),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Author name";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          Global.Authorname = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: Global.booknamecontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Book name",
                        label: Text("Book"),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Book Name";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          Global.Bookname = val!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (Global.insertdatakey.currentState!.validate()) {
                          Global.insertdatakey.currentState!.save();

                          Map<String, dynamic> data = {
                            "authorname": Global.Authornamecontroller.text,
                            "bookname": Global.booknamecontroller.text,
                            // "image": imagestring
                          };
                          DocumentReference docref = await FireStoreHelpers
                              .fireStoreHelpers
                              .insertdata(data: data);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "HomePage", (route) => false);
                        }
                      },
                      child: const Text("Add Book"),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDailog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () async {
                    try {
                      var pickedFile =
                          await _picker.pickImage(source: ImageSource.camera);

                      if (pickedFile != null) {
                        String imagepath = pickedFile.path;
                        print(imagepath);
                        setState(() {
                          image = pickedFile.path as File?;
                        });
                        File imagefile = File(imagepath);
                        Uint8List imagebytes = await imagefile.readAsBytes();
                        imagestring = base64.encode(imagebytes);
                        setState(() {});
                      } else {
                        print("No image is selected.");
                      }
                    } catch (e) {
                      print("error while picking file.");
                    }

                    // pickedImage =
                    //     await _picker.pickImage(source: ImageSource.camera);
                    //
                    // setState(() {
                    //   image = File(pickedImage!.path);
                    // });

                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.camera),
                ),
                IconButton(
                    onPressed: () async {
                      try {
                        var pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        //you can use ImageCourse.camera for Camera capture
                        if (pickedFile != null) {
                          String imagepath = pickedFile.path;

                          File imagefile =
                              File(imagepath); //convert Path to File
                          Uint8List imagebytes =
                              await imagefile.readAsBytes(); //convert to bytes
                          imagestring = base64.encode(
                              imagebytes); //convert bytes to base64 string

                          setState(() {});
                        } else {
                          print("No image is selected.");
                        }
                      } catch (e) {
                        print("error while picking file.");
                      }

                      // pickedImage =
                      //     await _picker.pickImage(source: ImageSource.gallery);
                      //
                      // setState(() {
                      //   image = File(pickedImage!.path);
                      // });

                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.browse_gallery)),
              ],
            ),
          );
        });
  }
}
