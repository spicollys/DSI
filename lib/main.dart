import 'package:dsi_app/pages/dsi_page.dart';
import 'package:dsi_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DSIApp());
}

class DSIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DSI App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/dsi_page': (context) => DSIPage(title: 'My First App - DSI/BSI/UFRPE'),
      },
    );
  }
}

