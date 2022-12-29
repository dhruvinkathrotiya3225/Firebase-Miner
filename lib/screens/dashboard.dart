import 'package:flutter/material.dart';

import '../Helpers/firebase_auth_helpers.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuthHelpers.firebaseAuthHelpers.signout();
              Navigator.of(context).pushReplacementNamed("HomePage");
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("HomePage");
            },
            icon: Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}
