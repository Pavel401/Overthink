import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotesController extends GetxController {
  String noteTitle = "";
  TextEditingController NoteTitleController = TextEditingController();
  TextEditingController note1 = TextEditingController();
  TextEditingController note2 = TextEditingController();
  TextEditingController note3 = TextEditingController();
  TextEditingController note4 = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
}
