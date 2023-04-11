import 'package:band_names_app/providers/socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names_app/screens/home.dart';
import 'package:band_names_app/screens/status.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _) => SocketProvider()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        //home: const HomeScreen(),
        initialRoute: 'home',
        routes: {
          'home': ( _) => const HomeScreen(),
          'status': ( _) => const StatusScreen()
        },
      ),
    );
  }
}