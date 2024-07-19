import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/view/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) =>
    const GetMaterialApp(debugShowCheckedModeBanner: false,
      home: SplashScreen(),));


  }
}
