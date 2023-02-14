// ignore_for_file: use_key_in_widget_constructors
import 'dart:io';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:moshahda_app/View/Pages/GetStarted.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'View/Pages/HomePage.dart';
import 'View/Pages/uploadScr.dart';
import 'ViewModel/Database/local/sharedPreferns.dart';
import 'firebase_options.dart';
import 'View/Pages/SplachScr.dart';

const apiKey = "AIzaSyAbKmjqsl6mj5JDYzN4buz3elqw2ff40ew";
const projectId = "moshahda";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await CashHelper.init();

  String? uId = CashHelper.getData(key: 'uId');
  Widget? widget;

  if (uId != null || Platform.isWindows) {
    widget = const HomePage();
  } else {
    widget = const GetStart();
  }
  if (!Platform.isWindows) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    Firestore.initialize(projectId);
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Moshahda',
      home: SplashScr(
        widget: widget,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
