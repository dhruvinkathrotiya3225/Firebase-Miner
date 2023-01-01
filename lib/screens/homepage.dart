import 'package:author_registration/helpers/firestore_helpers.dart';
import 'package:author_registration/modals/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Author Registration"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Global.booknamecontroller.clear();
          Global.Authornamecontroller.clear();
          setState(() {
            Global.Bookname = null;
            Global.Authorname = null;
          });
          Navigator.of(context).pushNamed("Add_Book");
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreHelpers.fireStoreHelpers.featchalldata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;

            List<QueryDocumentSnapshot> alldata = querySnapshot!.docs;

            return ListView.builder(
                itemCount: alldata.length,
                itemBuilder: (context, i) {
                  //   Uint8List decodedbytes = base64.decode(alldata[i]['images']);

                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Container(
                        //   height: 100,
                        //   width: 100,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: MemoryImage(decodedbytes)),
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "Author Name:         ${alldata[i]["authorname"]}",
                                      style: GoogleFonts.actor(
                                          fontSize: 17, color: Colors.white)),
                                  Text(
                                    " Book Name:          ${alldata[i]["bookname"]}",
                                    style: GoogleFonts.actor(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Delete record"),
                                                content: const Text(
                                                    "Are You sure want to delete this record"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        String id =
                                                            alldata[i].id;
                                                        FireStoreHelpers
                                                            .fireStoreHelpers
                                                            .deletedata(id: id);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("Delete")),
                                                  OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("cancel")),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Global.UpdateAuthornamecontroller.text =
                                            alldata[i]["authorname"];
                                        Global.Updatebooknamecontroller.text =
                                            alldata[i]["bookname"];
                                        Navigator.of(context).pushNamed(
                                            "Update_Book",
                                            arguments: alldata[i].id);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
