import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overthink/constants/Colors.dart';
import 'package:overthink/constants/Strings.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {},
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
      body: Column(
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
    );
  }
}
