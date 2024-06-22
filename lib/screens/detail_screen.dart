import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/models/item.dart';
import 'package:simple_app/providers/item_provider.dart';
import 'package:simple_app/screens/update_screen.dart';

class DetailScreen extends StatefulWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  // ignore: library_private_types_in_public_api
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: secondaryColor,
        iconTheme: const IconThemeData(
          color: textColor1,
        ),
        title: const Text(
          "Details View",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: textColor1,
            fontFamily: "Merriweather",
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
                    color: textColor2,
                    fontFamily: "Merriweather",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _item.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Rubik",
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
                    color: textColor2,
                    fontFamily: "Merriweather",
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _item.description,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: "Rubik",
                ),
              ),
              Lottie.asset(
                "assest/images/details_view.json",
                height: 450,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 5,
        color: secondaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () async {
          // Navigate to the UpdateItemScreen and wait for result
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateItemScreen(item: _item),
            ),
          );
          if (result == true) {
            setState(() {
              // replace the item with updated values
              _item = Provider.of<ItemProvider>(context, listen: false)
                  .items
                  .firstWhere((item) => item.id == _item.id);
            });
          }
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit,
          size: 50,
          color: textColor1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
