import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/models/item.dart';
import 'package:simple_app/screens/profile_screen.dart';

import '../providers/item_provider.dart';
import 'add_item_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY ITEMS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: textColor,
            fontFamily:"Merriweather",
          ),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        leading: IconButton(
            onPressed: () {
              //function for menu items
            },
            icon: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.menu,size: 30,),
            )
            ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Items',
                prefixIcon: const Icon(Icons.search, color: textColor),
                filled: true,
                fillColor: backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProfileScreen()), // Navigate to AddItemScreen
                    );
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assest/images/profilePic.png'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<ItemProvider>(
         // This widget listens to changes in the ItemProvider and rebuilds when data changes
        builder: (context, itemProvider, child) {
          final filteredItems = itemProvider.items
              .where((item) => item.title.toLowerCase().contains(_searchQuery))
              .toList();
        
          return ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  color: primaryColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    title: Text(
                      "${index + 1}. ${item.title}", // Show item title with index counter number in home screen.
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: textColor,
                        fontFamily: "Rubik",
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: textColor),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, itemProvider,
                            item); // Show delete confirmation method call.
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(item: item),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        color: secondaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 40,
                  color: textColor,
                ),
                onPressed: () {
                  // Navigate to HomeScreen
                },
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                size: 40,
                color: textColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ProfileScreen()), // Navigate to AddItemScreen
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AddItemScreen()), // Navigate to AddItemScreen
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 50,
          color: textColor,
          
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  // Show a dialog message to confirm item deletion
  void _showDeleteConfirmationDialog(
      BuildContext context, ItemProvider itemProvider, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Do you want to delete this item?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                itemProvider.removeItem(item);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    
  }
}
