import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/screens/home_screen.dart';

import '../models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item; // Item passed to this screen

  const DetailScreen({super.key, required this.item}); // Constructor to receive the item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_sharp,
            size: 40,
            weight: 400,
          ),
          onPressed: () => Navigator.pop(
              context, (const HomeScreen())), // Navigate back to home screen
        ),
        backgroundColor: secondaryColor,
        title: const Text(
          "Details View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Item Name :",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Item Description :",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Lottie.asset(
                "assest/images/details_view.json",
                height: 450,
              ), // Add animation image from lottie package
            ],
          ),
        ),
      ),
    );
  }
}
