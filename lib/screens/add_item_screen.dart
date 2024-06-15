import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/screens/home_screen.dart';

import '../models/item.dart';
import '../providers/item_provider.dart';

// Stateful widget to add items
class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for the form
  String _title = ''; // Variable declare to store the title
  String _description = ''; // Variable declare to store the description

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
          onPressed: () =>
              Navigator.pop(context, (const HomeScreen())), // Go back to home screen
        ),
        backgroundColor: secondaryColor,
        title: const Text(
          'ADD ITEM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Title',
                    labelStyle: TextStyle(fontSize: 25),
                  ),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                  maxLength: 25,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title..'; // Validation message
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!; // Save the title
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    labelStyle: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  style: const TextStyle(fontSize: 15),
                  maxLines: 4,
                  // maxLength: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description..'; // Validation message
                    }
                    if (value.length < 5) {
                      return 'Please enter a valid description'; // Validation message
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!; // Save the description
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Add item to the provider
                      Provider.of<ItemProvider>(context, listen: false).addItem(
                        Item(title: _title, description: _description),
                      );
                      Navigator.pop(context); // Go back to the home screen
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: secondaryColor,
                  ),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                // Add animation image from lottie package
                Lottie.asset(
                  "assest/images/add_item.json",
                  height: 450,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
