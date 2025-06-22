import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/widget/mainscreen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(412, 915), // Pixel 7 resolution
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Signup',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      home: const MainScreen(),
    );
  }
}
