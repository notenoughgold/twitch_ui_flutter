import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitch_ui_flutter/screens/home/HomeScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black,foregroundColor: Colors.white),
        splashColor: const Color(0x003700b3).withAlpha(160),
        tabBarTheme: const TabBarTheme(
            unselectedLabelColor: Colors.white,
            labelColor: Color.fromARGB(255, 179, 139, 239)),
        colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.blue,
            brightness: Brightness.dark,
            secondary: const Color.fromARGB(255, 179, 139, 239)),
      ),
      home: const HomeScreen(),
    );
  }
}
