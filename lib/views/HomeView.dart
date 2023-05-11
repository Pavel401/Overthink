import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overthink/constants/Colors.dart';
import 'package:overthink/constants/Strings.dart';
import 'package:overthink/model/NotesModel.dart';
import 'package:overthink/services/NoteServices.dart';
import 'package:overthink/views/AddNote.dart';
import 'package:overthink/views/EditNotes.dart';
import 'package:sizer/sizer.dart';
import 'package:splash_route/splash_route.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final loadedNotes = await NotesProvider.getNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  init() {}

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

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => AddNote(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                SplashRoute(
                  targetPage: AddNote(),
                  splashColor: AppColors.WowWhite,
                  startFractionalOffset: FractionalOffset.topRight,
                  transitionDuration: Duration(milliseconds: 1000),
                ),
              )
                  .then((value) {
                loadNotes();
              });

              // Navigator.push(context, _createRoute()).then((value) {
              //   loadNotes();
              // });
            },
            icon: Icon(
              Icons.add_outlined,
              size: 30,
              color: AppColors.WowWhite,
            ),
          ),
        ],
        title: Text(
          "Notes",
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            color: AppColors.WowWhite,
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.emptyNotes,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.WowGrey,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                DateTime dateTime =
                    DateTime.parse(notes[index].time.toString());

                int year = dateTime.year;
                int month = dateTime.month;
                int day = dateTime.day;
                return Bounceable(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      SplashRoute(
                        targetPage: EditNote(
                          index: index,
                          note: notes[index],
                        ),
                        splashColor: AppColors.WowWhite,
                        startFractionalOffset: FractionalOffset.center,
                        transitionDuration: Duration(milliseconds: 1000),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                      loadNotes();
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditNote(
                    //       index: index,
                    //       note: notes[index],
                    //     ),
                    //   ),
                    // ).then((value) {
                    // setState(() {});
                    // loadNotes();
                    // });
                  },
                  child: FadeInLeftBig(
                    child: Container(
                      height: 20.h,
                      width: 100.w,
                      margin: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        top: 2.h,
                      ),
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        top: 2.h,
                      ),
                      decoration: BoxDecoration(
                        // color: AppColors.WowGrey,

                        color: getRandomColor(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: Text(
                                  notes[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    removeNote(index);
                                  },
                                  icon: Icon(
                                    Icons.delete_outlined,
                                    color: AppColors.backgroundColor,
                                  ))
                            ],
                          ),
                          Text(
                            notes[index].note1,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.backgroundColor,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$day/$month/$year",
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.backgroundColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: notes.length),
    );
  }
}
