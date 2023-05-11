// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:overthink/constants/Colors.dart';
// import 'package:sizer/sizer.dart';

// import 'package:overthink/model/NotesModel.dart';

// class NoteCard extends StatelessWidget {
//   Note note;
//   NoteCard({
//     Key? key,
//     required this.note,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<Color> colors = [
//       HexColor("##8FC9F9"),
//       HexColor("#C9FFC0"),
//       HexColor("#CC3737"),
//       HexColor("#FFBCBC"),
//       HexColor("#FFFCC0"),
//       HexColor("#F9DCC4"),
//     ];

//     Color getRandomColor() {
//       Random random = Random();
//       int index = random.nextInt(colors.length);
//       return colors[index];
//     }

//     return Container(
//       height: 20.h,
//       margin: EdgeInsets.only(
//         left: 5.w,
//         right: 5.w,
//         top: 2.h,
//       ),
//       padding: EdgeInsets.only(
//         left: 5.w,
//         right: 5.w,
//         top: 2.h,
//       ),
//       decoration: BoxDecoration(
//         // color: AppColors.WowGrey,

//         color: getRandomColor(),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 note.title,
//                 style: GoogleFonts.inter(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w800,
//                   color: AppColors.backgroundColor,
//                 ),
//               ),
//               IconButton(
//                   onPressed: () {
//                     removeNote(index);
//                   },
//                   icon: Icon(
//                     Icons.delete_outlined,
//                     color: AppColors.backgroundColor,
//                   ))
//             ],
//           ),
//           Text(
//             notes[index].note1,
//             maxLines: 2,
//             style: GoogleFonts.inter(
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.backgroundColor,
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 "$day/$month/$year",
//                 style: GoogleFonts.inter(
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.backgroundColor,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
