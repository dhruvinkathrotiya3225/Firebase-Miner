import 'package:author_registration/helpers/firestore_helpers.dart';
import 'package:flutter/material.dart';

import '../modals/global.dart';

class Update_Book extends StatefulWidget {
  const Update_Book({Key? key}) : super(key: key);

  @override
  State<Update_Book> createState() => _Update_BookState();
}

class _Update_BookState extends State<Update_Book> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Update Book"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: Global.updatekey,
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
                                image: NetworkImage(
                                    "https://media.istockphoto.com/id/1306307586/photo/collection-of-old-books-in-library.jpg?b=1&s=170667a&w=0&k=20&c=qEyK-d-aFOds4EcAYWoBIKnO5ELCiSb1PZpW_WU8RZ4="),
                                fit: BoxFit.cover),
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
                      controller: Global.UpdateAuthornamecontroller,
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
                          Global.UpdateAuthorname = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: Global.Updatebooknamecontroller,
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
                          Global.UpdateBookname = val!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (Global.updatekey.currentState!.validate()) {
                          Global.updatekey.currentState!.save();

                          Map<String, dynamic> data = {
                            "authorname":
                                Global.UpdateAuthornamecontroller.text,
                            "bookname": Global.Updatebooknamecontroller.text,
                            // "image": imagestring
                          };

                          FireStoreHelpers.fireStoreHelpers
                              .updatedata(data: data, id: res);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "HomePage", (route) => false);
                        }
                      },
                      child: const Text("Update Book"),
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
}
