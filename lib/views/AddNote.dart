// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:overthink/constants/Colors.dart';
import 'package:overthink/constants/Strings.dart';
import 'package:overthink/controllers/AddNotesController.dart';
import 'package:overthink/model/NotesModel.dart';
import 'package:overthink/services/NoteServices.dart';

class AddNote extends StatefulWidget {
  int noteNo;
  AddNote({
    Key? key,
    required this.noteNo,
  }) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final addTitleController = Get.put(AddNotesController());
  List<Note> notes = [];
  Future<void> loadNotes() async {
    final loadedNotes = await NotesProvider.getNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  @override
  void initState() {
    super.initState();
    addTitleController.NoteTitleController.text =
        "Note" + widget.noteNo.toString();
    loadNotes();
  }

  Future<void> saveNotes() async {
    await NotesProvider.saveNotes(notes);
  }

  // Future<void> addNote() async {
  //   final newNote = Note(
  //     title: addTitleController.noteTitle,
  //     note1: '',
  //     note2: '',
  //     note3: '',
  //     note4: '',
  //     time: DateTime.now(),
  //   );

  //   setState(() {
  //     notes.add(newNote);
  //   });

  //   await saveNotes();
  // }

  Future<void> saveNote() async {
    final newNote = Note(
      title: addTitleController.NoteTitleController.text,
      note1: addTitleController.note1.text,
      note2: addTitleController.note2.text,
      note3: addTitleController.note3.text,
      note4: addTitleController.note4.text,
      time: DateTime.now(),
    );

    final notes = await NotesProvider.getNotes();
    notes.add(newNote);
    await NotesProvider.saveNotes(notes);

    // Navigate back to the notes list screen
    // Navigator.pop(context);
  }

  final _formKey = GlobalKey<FormState>();

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
  //                     if (addTitleController
  //                         .NoteTitleController.text.isNotEmpty) {
  //                       if (addTitleController.note1.text.isNotEmpty ||
  //                           addTitleController.note2.text.isNotEmpty ||
  //                           addTitleController.note3.text.isNotEmpty ||
  //                           addTitleController.note4.text.isNotEmpty) {
  //                         var _type = FeedbackType.success;
  //                         Vibrate.feedback(_type);
  //                         saveNote();

  //                         addTitleController.NoteTitleController.text = "";

  //                         addTitleController.note1.text = "";
  //                         addTitleController.note2.text = "";
  //                         addTitleController.note3.text = "";
  //                         addTitleController.note4.text = "";

  //                         Get.back();
  //                         Get.back();
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

    if (addTitleController.NoteTitleController.text == "") {
      addTitleController.NoteTitleController.text =
          "Note " + widget.noteNo.toString();
    }
    saveNote();

    addTitleController.NoteTitleController.text = "";

    addTitleController.note1.text = "";
    addTitleController.note2.text = "";
    addTitleController.note3.text = "";
    addTitleController.note4.text = "";

    Get.back();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        // floatingActionButton: GestureDetector(
        //   onTap: () async {
        //     // if (addTitleController.NoteTitleController.text.isNotEmpty) {
        //     //   if (addTitleController.note1.text.isNotEmpty ||
        //     //       addTitleController.note2.text.isNotEmpty ||
        //     //       addTitleController.note3.text.isNotEmpty ||
        //     //       addTitleController.note4.text.isNotEmpty) {
        //     //     showDialog(
        //     //         context: context,
        //     //         builder: (context) => AlertDialog(
        //     //               backgroundColor: AppColors.WowGrey,
        //     //               title: Text("Do you want to save the Note?",
        //     //                   style: GoogleFonts.inter(
        //     //                     fontSize: 12.sp,
        //     //                     fontWeight: FontWeight.w900,
        //     //                     color: AppColors.WowWhite,
        //     //                   )),
        //     //               content: Row(
        //     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     //                 children: [
        //     //                   ElevatedButton(
        //     //                       onPressed: () {
        //     //                         var _type = FeedbackType.success;
        //     //                         Vibrate.feedback(_type);
        //     //                         saveNote();

        //     //                         addTitleController
        //     //                             .NoteTitleController.text = "";

        //     //                         addTitleController.note1.text = "";
        //     //                         addTitleController.note2.text = "";
        //     //                         addTitleController.note3.text = "";
        //     //                         addTitleController.note4.text = "";

        //     //                         Get.back();
        //     //                         Get.back();
        //     //                         // Go back to the previous screen
        //     //                       },
        //     //                       child: Text("Yes")),
        //     //                   ElevatedButton(
        //     //                       onPressed: () {
        //     //                         Get.back();
        //     //                         Get.back();
        //     //                       },
        //     //                       child: Text("Cancel"))
        //     //                 ],
        //     //               ),
        //     //             ));
        //     //   } else {
        //     //     ScaffoldMessenger.of(context).showSnackBar(
        //     //       const SnackBar(content: Text('Write atleast one note')),
        //     //     );
        //     //   }
        //     // } else {
        //     //   ScaffoldMessenger.of(context).showSnackBar(
        //     //     const SnackBar(content: Text('Enter Title')),
        //     //   );
        //     // }

        //     var _type = FeedbackType.success;
        //     Vibrate.feedback(_type);

        //     if (addTitleController.NoteTitleController.text == "") {
        //       addTitleController.NoteTitleController.text =
        //           "Note " + widget.noteNo.toString();
        //     }
        //     saveNote();

        //     addTitleController.NoteTitleController.text = "";

        //     addTitleController.note1.text = "";
        //     addTitleController.note2.text = "";
        //     addTitleController.note3.text = "";
        //     addTitleController.note4.text = "";

        //     Get.back();
        //     // Get.to(() => EditNotes()
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
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.save_alt_outlined,
            //     size: 30,
            //     color: AppColors.WowWhite,
            //   ),
            // ),
          ],
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
              controller: addTitleController.NoteTitleController,
              maxLines: 1,
              // maxLength: 15,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.WowGrey,
                ),
              ),

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
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
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
                        onTap: () {
                          setState(() {
                            isActiveFirst = !isActiveFirst;
                            isActiveSecond = false;
                            isActiveThird = false;
                            isActiveFourth = false;
                          });
                        },
                        cursorColor: AppColors.WowBlue,
                        style: GoogleFonts.inter(
                          color: AppColors.WowBlue,
                        ),
                        controller: addTitleController.note1,
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
                        controller: addTitleController.note2,
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
                        controller: addTitleController.note3,
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
                        controller: addTitleController.note4,
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
