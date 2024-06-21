import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/models/item.dart';
import 'package:simple_app/providers/item_provider.dart';

class UpdateItemScreen extends StatefulWidget {
  final Item item; // Item to be updated

  const UpdateItemScreen({super.key, required this.item});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateItemScreenState createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title; // Variable to hold the updated title
  late String _description; // Variable to hold the updated description

  @override
  // Initialize the title and description with the current item's values
  void initState() {
    super.initState();
    _title = widget.item.title;
    _description = widget.item.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: secondaryColor,
        title: const Text(
          'UPDATE ITEM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: textColor,
            fontFamily: "Merriweather",
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
              //getting user input for edit the title and description. and let to edit exsisting values.
              children: [
                TextFormField(
                  initialValue: _title,
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
                    _title = value!;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  initialValue: _description,
                  decoration: const InputDecoration(
                    labelText: 'Enter Description',
                    labelStyle: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  style: const TextStyle(fontSize: 15),
                  maxLines: 4,
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
                    _description = value!;
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Provider.of<ItemProvider>(context, listen: false)
                          .updateItem(widget.item.id, _title, _description);
                      Navigator.pop(context, true); // Indicate success
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: secondaryColor,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Lottie.asset(
                  "assest/images/loading.json",
                  height: 400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
