import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overthink/constants/Colors.dart';
import 'package:overthink/constants/Strings.dart';
import 'package:overthink/controllers/AddNotesController.dart';
import 'package:overthink/model/NotesModel.dart';
import 'package:overthink/services/NoteServices.dart';
import 'package:sizer/sizer.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (addTitleController.NoteTitleController.text.isNotEmpty) {
            if (addTitleController.note1.text.isNotEmpty ||
                addTitleController.note2.text.isNotEmpty ||
                addTitleController.note3.text.isNotEmpty ||
                addTitleController.note4.text.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: AppColors.WowGrey,
                        title: Text("Do you want to save the Note?",
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
                                  saveNote();

                                  addTitleController.NoteTitleController.text =
                                      "";

                                  addTitleController.note1.text = "";
                                  addTitleController.note2.text = "";
                                  addTitleController.note3.text = "";
                                  addTitleController.note4.text = "";

                                  Get.back();
                                  Get.back();
                                  // Go back to the previous screen
                                },
                                child: Text("Yes")),
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"))
                          ],
                        ),
                      ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Write atleast one note')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Enter Title')),
            );
          }
          // Get.to(() => EditNotes()
        },
        child: CircleAvatar(
            backgroundColor: AppColors.WowGrey,
            radius: 30,
            child: Icon(
              Icons.save,
              size: 30,
              color: AppColors.WowWhite,
            )),
      ),
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
            onPressed: () {
              Get.back();
            },
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
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
            // },
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
                      border: Border.all(color: AppColors.WowWhite),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 100,
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
                      border: Border.all(color: AppColors.WowWhite),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: AppColors.WowPink,
                      maxLines: 100,
                      style: GoogleFonts.inter(
                        color: AppColors.WowPink,
                      ),
                      controller: addTitleController.note2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 42.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      border: Border.all(color: AppColors.WowWhite),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 100,
                      cursorColor: AppColors.WowGreen,
                      style: GoogleFonts.inter(
                        color: AppColors.WowGreen,
                      ),
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
                      border: Border.all(color: AppColors.WowWhite),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 100,
                      cursorColor: AppColors.WowYellow,
                      style: GoogleFonts.inter(
                        color: AppColors.WowYellow,
                      ),
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
    );
  }
}
