import 'dart:core';

import 'package:p24_sdk/transfer/passage_item.dart';

class PassageCart {

  final List<PassageItem> _items;

  PassageCart(this._items);

  void addItem(PassageItem item) => _items.add(item);
  List<PassageItem> get items => _items;

  int getSummaryPrice() {
    return _items
        .map((item) => item.price)
        .reduce((a, b) => a + b);
  }

  List<dynamic> toMap() {
    return _items
        .map(_mapPassage)
        .toList();
  }

  Map<String, Object> _mapPassage(PassageItem item) {
    return {
      "name" : item.name,
      "description" : item.description,
      "quantity" : item.quantity,
      "price" : item.price,
      "number" : item.number,
      "targetAmount" : item.targetAmount,
      "targetPosId" : item.targetPosId
    };
  }

}