import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overthink/constants/Colors.dart';
import 'package:overthink/views/HomeView.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1), () {
      Get.offAll(HomeView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: AppColors.backgroundColor,
        //   elevation: 0,
        // ),
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(color: AppColors.WowGrey),
        ),
        Positioned(
            bottom: 50.h, child: SvgPicture.asset("assets/svg/logo.png")),
        // Positioned(
        //   bottom: 52.h,
        //   child: SizedBox(
        //     height: 2.h,
        //   ),
        // ),
        Positioned(
          bottom: 55.h,
          child: SvgPicture.asset(
            "assets/svg/logo.svg",
            width: 120.sp,
          ),
        ),
        Positioned(
          bottom: 45.h,
          child: Text(
            "Overthink",
            style: GoogleFonts.dmSans(
                color: AppColors.GreyText,
                fontWeight: FontWeight.w700,
                fontSize: 20.sp),
          ),
        ),
        Positioned(
          bottom: 38.h,
          child: SizedBox(
            width: 60.w,
            child: Text(
              "A simple text tool to help you think multidimensionally",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                  color: AppColors.GreyText,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 22,
              child: CircleAvatar(
                radius: 13,
                backgroundColor: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    // backgroundColor: Colors.white,
                    // color: Colors.white,
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.WowYellow),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
