import 'dart:convert' show json;
import 'package:dosparkles/actions/app_config.dart';
import 'package:dosparkles/models/product_item.dart';
import 'package:flutter/material.dart';
import 'package:dosparkles/utils/general.dart';

class CartItem {
 ProductItem product;
 int count;
 dynamic engraveInputs;

  CartItem.fromParams(
      {this.product,
      this.count,
      this.engraveInputs});

  @override
  String toString() {
    return '${product.toString()} count: $count';
  }
}
