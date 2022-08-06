import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smstopia/bindings/sms_binding.dart';
import 'package:smstopia/screens/home_screen.dart';

void main() async {
  await GetStorage.init();
  SMSBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SMSBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScren(),
    );
  }
}
