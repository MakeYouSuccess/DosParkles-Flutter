import 'dart:convert' show json;
import 'package:com.floridainc.dosparkles/actions/app_config.dart';
import 'package:com.floridainc.dosparkles/models/product_item.dart';
import 'package:flutter/material.dart';
import 'package:com.floridainc.dosparkles/utils/general.dart';

class CartItem {
  ProductItem product;
  int count;
  dynamic engraveInputs;
  double amount;

  CartItem.fromParams({this.product, this.count, this.engraveInputs, this.amount});

  @override
  String toString() {
    return '${product.toString()} count: $count amount: $amount';
  }
}
