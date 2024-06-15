import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/item_provider.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const MyApp()); // This starts the app by calling the MyApp widget
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider provides the ItemProvider to the widget tree
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(), // Create an instance of ItemProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple App',
        theme: ThemeData(),
        home: const HomeScreen(), // The starting screen of the app
      ),
    );
  }
}