import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'MyHomePage/MyHomePage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // غير الأبعاد إذا كان لديك تصميم آخر
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ahmed Maher Portfolio',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: PortfolioWebApp(),
        );
      },
    );
  }
}
