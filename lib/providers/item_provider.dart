import 'package:flutter/material.dart';
import 'package:simple_app/models/item.dart';

class ItemProvider with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

// This function adds a new item to the list. It takes a title and description, creates a new item with a unique ID based on the current date and time, and then adds it to the list. After that, it notifies all listeners about the change so the UI can update at that time.
  void addItem(String title, String description) {
    final newItem = Item(
        id: DateTime.now().toString(), title: title, description: description);
    _items.add(newItem);
    notifyListeners();
  }

// This function removes an existing item from the list. It takes an item object as input, removes it from the list, and then notifies all listeners about the change so the UI can update at that time.
  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

// This function updates the title and description of an existing item. It takes the item's ID, new title, and description as inputs. It finds the item's index in the list using the ID. If the item is found, it creates a new item with the updated title and description, replacing the old item in the list. After the update, it notifies all listeners about the change so the UI can update according to that changes.
  void updateItem(String id, String newTitle, String newDescription) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] =
          Item(id: id, title: newTitle, description: newDescription);
      notifyListeners();
    }
  }
}
