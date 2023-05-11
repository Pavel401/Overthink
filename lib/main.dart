import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:overthink/views/HomeView.dart';
import 'package:overthink/views/Splash.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true),
        home: HomeView(),
      );
    });
  }
}
