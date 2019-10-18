import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitch_ui_flutter/screens/home/HomeScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          accentColor: Color.fromARGB(255, 179, 139, 239),
          appBarTheme: AppBarTheme(color: Colors.black),
          splashColor: Color(0x3700B3).withAlpha(160),
          tabBarTheme: TabBarTheme(
              unselectedLabelColor: Colors.white,
              labelColor: Color.fromARGB(255, 179, 139, 239))),
      home: HomeScreen(),
    );
  }
}
