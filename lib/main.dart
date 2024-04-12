import 'package:flutter/material.dart';

import 'screens/user_register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sciflare Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const UserRegisterScreen());
  }
}
