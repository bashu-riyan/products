import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:products/widgets/checkingPage.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'google_sign_in.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFC8A42),
      systemNavigationBarColor: Color(0xFFFC8A42),
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
          child: MaterialApp(home: Check()),

    );
  }
}
