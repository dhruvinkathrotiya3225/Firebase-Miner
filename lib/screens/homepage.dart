import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/helpers/fire_store_helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> InsertNoteKey = GlobalKey();
  TextEditingController TitleController = TextEditingController();
  TextEditingController NoteController = TextEditingController();
  GlobalKey<FormState> UpdateNoteKey = GlobalKey();
  TextEditingController UpdateTitleController = TextEditingController();
  TextEditingController UpdateNoteController = TextEditingController();
  String id = "";
  String? title;
  String? note;
  String? Updatetitle;
  String? Updatenote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: insertnote,
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FireStoreHelpers.fireStoreHelpers.featchAllRecord(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? querysnapshot = snapshot.data;
            List<QueryDocumentSnapshot> allnotes = querysnapshot!.docs;

            return ListView.builder(
                itemCount: allnotes.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text("${allnotes[i]["title"]}"),
                      subtitle: Text("${allnotes[i]["note"]}"),
                      // leading: Text("${allnotes[i]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete Record"),
                                      content: Text(
                                          "Are you sure you want to delete this"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            FireStoreHelpers.fireStoreHelpers
                                                .deleterecord(
                                                    id: allnotes[i].id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text("Delete Sucessfully"),
                                              backgroundColor: Colors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ));
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: const Text("Delete"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("cancel"),
                                          style: ElevatedButton.styleFrom(
                                              onPrimary: Colors.black),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              id = allnotes[i].id;
                              UpdateTitleController.text = allnotes[i]["title"];
                              UpdateNoteController.text = allnotes[i]["note"];
                              updatenote();
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      onLongPress: () {},
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("DetailPage", arguments: allnotes[i]);
                      },
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  insertnote() {
    showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text("Add Note"),
        content: Form(
          key: InsertNoteKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: TitleController,
                decoration: const InputDecoration(
                  hintText: " title",
                  label: Text("Enter Title"),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter title";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    title = val!;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: NoteController,
                decoration: const InputDecoration(
                  hintText: "Note",
                  label: Text("Enter Note"),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Note";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    note = val!;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (InsertNoteKey.currentState!.validate()) {
                InsertNoteKey.currentState!.save();

                Map<String, dynamic> data = {
                  "title": TitleController.text,
                  "note": NoteController.text,
                };
                DocumentReference<Map<String, dynamic>> docref =
                    await FireStoreHelpers.fireStoreHelpers
                        .insertdata(data: data);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Insert Successfully"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
              TitleController.clear();
              NoteController.clear();
              setState(() {
                title = null;
                note = null;
              });
            },
            style: ElevatedButton.styleFrom(primary: Colors.black),
            child: const Text("Add Note"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(onPrimary: Colors.black),
            child: const Text(
              "cancel",
            ),
          ),
        ],
      ),
    );
  }

  updatenote() {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text("Update Note"),
            content: Form(
              key: UpdateNoteKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: UpdateTitleController,
                    decoration: const InputDecoration(
                      hintText: " title",
                      label: Text("Enter Title"),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter title";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        Updatetitle = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: UpdateNoteController,
                    decoration: const InputDecoration(
                      hintText: "Note",
                      label: Text("Enter Note"),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Note";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      setState(() {
                        Updatenote = val!;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (UpdateNoteKey.currentState!.validate()) {
                    UpdateNoteKey.currentState!.save();

                    Map<String, dynamic> data = {
                      "title": UpdateTitleController.text,
                      "note": UpdateNoteController.text,
                    };
                    FireStoreHelpers.fireStoreHelpers
                        .updatedata(data: data, id: id);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Update Successfully"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                  UpdateTitleController.clear();
                  UpdateNoteController.clear();
                  setState(() {
                    Updatetitle = null;
                    Updatenote = null;
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.black),
                child: const Text("Update Note"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(onPrimary: Colors.black),
                child: const Text(
                  "cancel",
                ),
              ),
            ],
          );
        });
  }
}
