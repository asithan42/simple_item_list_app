import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/models/item.dart';

import '../providers/item_provider.dart';
import 'add_item_screen.dart';
import 'detail_screen.dart';

// Define a stateless widget called HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ITEM LIST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: secondaryColor,
        leading: const Icon(
          Icons.menu,
          size: 45,
        ),
      ),

      // Consumer widget listens to changes in the ItemProvider
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          return ListView.builder(
            itemCount: itemProvider.items.length, // Number of items in the list
            itemBuilder: (context, index) {
              final item = itemProvider.items[index];
              return ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                           "${++index}. ${item.title}", // show item title with index counter number in home screen.
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: textColor,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: textColor),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, itemProvider,
                              item); // Show delete confirmation method call.
                        },
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: secondaryColor,
            elevation: 10,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddItemScreen()),
                // Navigate to AddItemScreen
              );
            },
            child: const Icon(
              Icons.add,
              size: 45,
              color: textColor,
            ),
          ),
        ),
      ),
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
