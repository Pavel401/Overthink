// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import 'package:overthink/constants/Colors.dart';
import 'package:overthink/constants/Strings.dart';
import 'package:overthink/model/NotesModel.dart';
import 'package:overthink/services/NoteServices.dart';
import 'package:overthink/views/AddNote.dart';

class EditNote extends StatefulWidget {
  Note note;
  int index;
  EditNote({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController NoteTitleController = TextEditingController(
    text: "",
  );
  TextEditingController note1 = TextEditingController(
    text: "",
  );
  TextEditingController note2 = TextEditingController(
    text: "",
  );
  TextEditingController note3 = TextEditingController(
    text: "",
  );
  TextEditingController note4 = TextEditingController(
    text: "",
  );
  GlobalKey key = GlobalKey();
  List<Note> notes = [];
  Future<void> loadNotes() async {
    final loadedNotes = await NotesProvider.getNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  init() {
    setState(() {
      NoteTitleController.text = widget.note.title;
      note1.text = widget.note.note1;
      note2.text = widget.note.note2;
      note3.text = widget.note.note3;
      note4.text = widget.note.note4;
    });
    print("note title : " + NoteTitleController.text);
  }

  @override
  void initState() {
    init();
    loadNotes();

    super.initState();
  }

  final List<Color> colors = [
    HexColor("##8FC9F9"),
    HexColor("#C9FFC0"),
    HexColor("#CC3737"),
    HexColor("#FFBCBC"),
    HexColor("#FFFCC0"),
    HexColor("#F9DCC4"),
  ];

  Color getRandomColor() {
    Random random = Random();
    int index = random.nextInt(colors.length);
    return colors[index];
  }

  Future<void> saveNotes() async {
    await NotesProvider.saveNotes(notes);
  }

  Future<void> removeNote(int index) async {
    setState(() {
      notes.removeAt(index);
    });

    await saveNotes();
  }

  Future<void> updateNote(int index, Note updatedNote) async {
    setState(() {
      notes[index] = updatedNote;
    });

    await saveNotes();
  }

  bool isActiveFirst = false;
  bool isActiveSecond = false;
  bool isActiveThird = false;
  bool isActiveFourth = false;
  // Future<bool> _onBackPressed() async {
  //   return await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: AppColors.WowGrey,
  //           title: Text("Do you want to save the Note?",
  //               style: GoogleFonts.inter(
  //                 fontSize: 12.sp,
  //                 fontWeight: FontWeight.w900,
  //                 color: AppColors.WowWhite,
  //               )),
  //           content: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               ElevatedButton(
  //                   onPressed: () {
  //                     if (NoteTitleController.text.isNotEmpty) {
  //                       if (note1.text.isNotEmpty ||
  //                           note2.text.isNotEmpty ||
  //                           note3.text.isNotEmpty ||
  //                           note4.text.isNotEmpty) {
  //                         var _type = FeedbackType.success;
  //                         Vibrate.feedback(_type);
  //                         updateNote(
  //                             widget.index,
  //                             Note(
  //                               title: NoteTitleController.text,
  //                               note1: note1.text,
  //                               note2: note2.text,
  //                               note3: note3.text,
  //                               note4: note4.text,
  //                               time: DateTime.now(),
  //                             ));
  //                         Navigator.pop(context);
  //                         Navigator.pop(context);

  //                         NoteTitleController.text = "";

  //                         note1.text = "";
  //                         note2.text = "";
  //                         note3.text = "";
  //                         note4.text = "";
  //                       } else {
  //                         ScaffoldMessenger.of(context).showSnackBar(
  //                           const SnackBar(
  //                               content: Text('Write atleast one note')),
  //                         );
  //                         Get.back();
  //                       }
  //                     } else {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         const SnackBar(content: Text('Enter Title')),
  //                       );
  //                       Get.back();
  //                     }
  //                   },
  //                   child: Text("Yes")),
  //               ElevatedButton(
  //                   onPressed: () {
  //                     Get.back();
  //                     Get.back();
  //                   },
  //                   child: Text("Cancel"))
  //             ],
  //           ),
  //         );
  //       });
  // }

  Future<bool> _onBackPressed() async {
    var _type = FeedbackType.success;
    Vibrate.feedback(_type);

    if (NoteTitleController.text.isEmpty) {
      NoteTitleController.text = "Note " + widget.index.toString();
    }
    updateNote(
        widget.index,
        Note(
          title: NoteTitleController.text,
          note1: note1.text,
          note2: note2.text,
          note3: note3.text,
          note4: note4.text,
          time: DateTime.now(),
        ));
    note1.text = "";
    note2.text = "";
    note3.text = "";
    note4.text = "";
    Navigator.pop(context);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        // floatingActionButton: GestureDetector(
        //   onTap: () async {
        //     // saveNote();

        //     // showDialog(
        //     //     context: context,
        //     //     builder: (context) => AlertDialog(
        //     //           backgroundColor: AppColors.WowGrey,
        //     //           title: Text("Do you want to save the changes?",
        //     //               style: GoogleFonts.inter(
        //     //                 fontSize: 12.sp,
        //     //                 fontWeight: FontWeight.w900,
        //     //                 color: AppColors.WowWhite,
        //     //               )),
        //     //           content: Row(
        //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //             children: [
        //     //               ElevatedButton(
        //     //                   onPressed: () {
        //     //                     var _type = FeedbackType.success;
        //     //                     Vibrate.feedback(_type);
        //     //                     updateNote(
        //     //                         widget.index,
        //     //                         Note(
        //     //                           title: NoteTitleController.text,
        //     //                           note1: note1.text,
        //     //                           note2: note2.text,
        //     //                           note3: note3.text,
        //     //                           note4: note4.text,
        //     //                           time: DateTime.now(),
        //     //                         ));
        //     //                     Navigator.pop(context);
        //     //                     Navigator.pop(context);
        //     //                   },
        //     //                   child: Text("Yes")),
        //     //               ElevatedButton(
        //     //                   onPressed: () {
        //     //                     var _type = FeedbackType.error;
        //     //                     Vibrate.feedback(_type);
        //     //                     Get.back();
        //     //                     Get.back();
        //     //                   },
        //     //                   child: Text("Cancel"))
        //     //             ],
        //     //           ),
        //     //         ));

        //     var _type = FeedbackType.success;
        //     Vibrate.feedback(_type);

        //     if (NoteTitleController.text.isEmpty) {
        //       NoteTitleController.text = "Note " + widget.index.toString();
        //     }
        //     updateNote(
        //         widget.index,
        //         Note(
        //           title: NoteTitleController.text,
        //           note1: note1.text,
        //           note2: note2.text,
        //           note3: note3.text,
        //           note4: note4.text,
        //           time: DateTime.now(),
        //         ));
        //     note1.text = "";
        //     note2.text = "";
        //     note3.text = "";
        //     note4.text = "";
        //     Navigator.pop(context);
        //   },
        //   child: CircleAvatar(
        //       backgroundColor: AppColors.WowGrey,
        //       radius: 30,
        //       child: Icon(
        //         Icons.save,
        //         size: 30,
        //         color: AppColors.WowWhite,
        //       )),
        // ),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.WowGrey,
                          title: Text("Do you want to delete the note?",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.WowWhite,
                              )),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    var _type = FeedbackType.success;
                                    Vibrate.feedback(_type);
                                    removeNote(widget.index);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                  },
                                  child: Text("Cancel"))
                            ],
                          ),
                        ));
              },
              icon: Icon(
                Icons.delete_outline,
                size: 30,
                color: AppColors.WowWhite,
              ),
            ),
          ],
          // title: Text(
          //   "Notes",
          // style: GoogleFonts.inter(
          //   fontSize: 18.sp,
          //   fontWeight: FontWeight.w900,
          //   color: AppColors.WowWhite,
          // ),
          // ),
          centerTitle: true,
          leading: IconButton(
              onPressed: _onBackPressed,
              icon: Icon(
                Icons.chevron_left_outlined,
                size: 30,
                color: AppColors.WowWhite,
              )),
          title: SizedBox(
            width: 150.sp,
            child: TextFormField(
              controller: NoteTitleController,
              maxLines: 1,
              // maxLength: 15,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
                color: AppColors.WowWhite,
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 42.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: isActiveFirst ? 4 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: TextFormField(
                        maxLines: 100,
                        cursorColor: AppColors.WowBlue,
                        onTap: () {
                          setState(() {
                            isActiveFirst = !isActiveFirst;
                            isActiveSecond = false;
                            isActiveThird = false;
                            isActiveFourth = false;
                          });
                        },
                        style: GoogleFonts.inter(
                          color: AppColors.WowBlue,
                        ),
                        controller: note1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 42.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: isActiveSecond ? 4 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: TextFormField(
                        cursorColor: AppColors.WowPink,
                        maxLines: 100,
                        style: GoogleFonts.inter(
                          color: AppColors.WowPink,
                        ),
                        onTap: () {
                          setState(() {
                            isActiveFirst = false;
                            isActiveSecond = !isActiveSecond;
                            isActiveThird = false;
                            isActiveFourth = false;
                          });
                        },
                        controller: note2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 42.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: isActiveThird ? 4 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: TextFormField(
                        maxLines: 100,
                        cursorColor: AppColors.WowGreen,
                        style: GoogleFonts.inter(
                          color: AppColors.WowGreen,
                        ),
                        onTap: () {
                          setState(() {
                            isActiveFirst = false;
                            isActiveSecond = false;
                            isActiveThird = !isActiveThird;
                            isActiveFourth = false;
                          });
                        },
                        controller: note3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 42.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: isActiveFourth ? 4 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: TextFormField(
                        maxLines: 100,
                        cursorColor: AppColors.WowYellow,
                        style: GoogleFonts.inter(
                          color: AppColors.WowYellow,
                        ),
                        onTap: () {
                          setState(() {
                            isActiveFirst = false;
                            isActiveSecond = false;
                            isActiveThird = false;
                            isActiveFourth = !isActiveFourth;
                          });
                        },
                        controller: note4,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
