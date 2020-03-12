import 'package:flutter/cupertino.dart';

class PassageItem {
  final String _name;
  final String _description;
  final int _quantity;
  final int _price;
  final int _number;
  final int _targetAmount;
  final _targetPosId;

  PassageItem(
      {@required String name,
      @required String description,
      @required int quantity,
      @required int price,
      @required int number,
      @required int targetAmount,
      @required int targetPosId})
      : this._name = name,
        this._description = description,
        this._quantity = quantity,
        this._price = price,
        this._number = number,
        this._targetAmount = targetAmount,
        this._targetPosId = targetPosId;

  int get targetPosId => _targetPosId;
  int get targetAmount => _targetAmount;
  int get number => _number;
  int get price => _price;
  int get quantity => _quantity;
  String get description => _description;
  String get name => _name;

  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "description": _description,
      "quantity": _quantity,
      "price": _price,
      "number": _number,
      "targetAmount": _targetAmount,
      "targetPosId": _targetPosId,
    };
  }
}
