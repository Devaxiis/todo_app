
import 'package:flutter/material.dart';

import 'package:todo_app/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}