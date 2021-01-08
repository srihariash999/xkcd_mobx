import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:xkcd_mobx/ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xkcd Viewer',
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: HomeScreen(),
    );
  }
}
