import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Helpers/firebase_auth_helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  GlobalKey<FormState> signupuserkey = GlobalKey();
  GlobalKey<FormState> signInuserkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? email;
  String? password;
  bool isClickLogin = false;
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height * 0.50,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.amberAccent, Colors.orange],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  "Welcome",
                  style: GoogleFonts.asar(color: Colors.white, fontSize: 33),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 200, left: 30),
            alignment: Alignment.center,
            height: height * 0.40,
            width: width * 0.85,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 3),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            emailcontroller.clear();
                            passwordcontroller.clear();
                            setState(() {
                              email = null;
                              password = null;
                              isClickLogin = false;
                            });
                          },
                          child: Container(
                            child: Text(
                              "SIGNUP",
                              style: GoogleFonts.arvo(
                                color: (isClickLogin == false)
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            emailcontroller.clear();
                            passwordcontroller.clear();
                            setState(() {
                              email = null;
                              password = null;
                              isClickLogin = true;
                            });
                          },
                          child: Container(
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.arvo(
                                color: (isClickLogin == true)
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    (isClickLogin == false)
                        ? Form(
                            key: signupuserkey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: emailcontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.email),
                                      hintText: "Enter your email",
                                      label: Text("Email"),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter first email";
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: passwordcontroller,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.password),
                                      border: OutlineInputBorder(),
                                      hintText: "Enter your password",
                                      label: Text("Password"),
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Please enter password";
                                      } else if (val!.length < 6) {
                                        return "Please enter minimum 6 character";
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        password = val!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Form(
                            key: signInuserkey,
                            child: Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: emailcontroller,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.email),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Email First ",
                                        label: Text("Email"),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please enter your email";
                                        }
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          email = val!;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      controller: passwordcontroller,
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.password),
                                        border: OutlineInputBorder(),
                                        hintText: "Enter password First ",
                                        label: Text("Password"),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please enter your email";
                                        }
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          password = val!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          (isClickLogin == false)
              ? GestureDetector(
                  onTap: () async {
                    if (signupuserkey.currentState!.validate()) {
                      signupuserkey.currentState!.save();
                      try {
                        User? user = await FirebaseAuthHelpers
                            .firebaseAuthHelpers
                            .signUp(email: email!, password: password!);

                        if (user != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Sign up successful"),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign up faild"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${e.message}"),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 480, left: 150),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent.shade100,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () async {
                    if (signInuserkey.currentState!.validate()) {
                      signInuserkey.currentState!.save();
                      try {
                        User? user = await FirebaseAuthHelpers
                            .firebaseAuthHelpers
                            .signIn(email: email!, password: password!);
                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Sign in successfully"),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "Dashboard", (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("signIn failed"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${e.message}"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 480, left: 150),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent.shade100,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
          GestureDetector(
            onTap: () async {
              User? user = await FirebaseAuthHelpers.firebaseAuthHelpers
                  .signInWithGoogle();
              if (user != null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Login successfully With Google"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
                Navigator.of(context).pushReplacementNamed("Dashboard");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Login failed "),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 650, left: 10),
                height: 60,
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "SignUp with Google",
                  style: GoogleFonts.asap(color: Colors.white, fontSize: 24),
                )),
          ),
        ],
      ),
    );
  }
}
