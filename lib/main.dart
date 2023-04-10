import 'package:band_names_app/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomeScreen(),
      initialRoute: 'home',
      routes: {
        'home': ( _) => const HomeScreen(),
      },
    );
  }
}