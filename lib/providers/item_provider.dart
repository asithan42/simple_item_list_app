import 'package:flutter/material.dart';

import '../models/item.dart';

// Define a class called ItemProvider that uses ChangeNotifier
class ItemProvider with ChangeNotifier {
  final List<Item> _items = []; // Private list of items

  List<Item> get items => _items; // Getter to access the list of items

  // Method to add an item to the list
  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  // Method to remove an item from the list
  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
