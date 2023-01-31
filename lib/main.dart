// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:moshahda_app/View/Pages/GetStarted.dart';
import 'View/Pages/HomePage.dart';
import 'ViewModel/Database/local/sharedPreferns.dart';
import 'firebase_options.dart';

import 'View/Pages/SplachScr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  String? uId = CashHelper.getData(key: 'uId');
  Widget? widget;

  if (uId != null) {
    widget = HomePage();
  } else
    widget = GetStart();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
