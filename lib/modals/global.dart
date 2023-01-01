import 'dart:io';

import 'package:flutter/cupertino.dart';

class Global {
  static GlobalKey<FormState> insertdatakey = GlobalKey();
  static TextEditingController Authornamecontroller = TextEditingController();
  static TextEditingController booknamecontroller = TextEditingController();
  static GlobalKey<FormState> updatekey = GlobalKey();
  static TextEditingController UpdateAuthornamecontroller =
      TextEditingController();
  static TextEditingController Updatebooknamecontroller =
      TextEditingController();

  File? image;
  static String? Authorname;
  static String? Bookname;
  static String? UpdateAuthorname;
  static String? UpdateBookname;
}
