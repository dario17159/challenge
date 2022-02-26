import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickit_challenge/presentation/pages/home/home_binding.dart';
import 'package:pickit_challenge/presentation/pages/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pickit',
      home: HomePage(),
      initialBinding: HomeBinding(),
    );
  }
}
