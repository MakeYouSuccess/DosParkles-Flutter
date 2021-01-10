import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/models.dart';

class ProductPageState
    implements GlobalBaseState, Cloneable<ProductPageState> {
  AnimationController animationController;

  @override
  ProductPageState clone() {
    return ProductPageState()..animationController = animationController;
  }


  @override
  Locale locale;

  @override
  AppUser user;

  @override
  List<StoreItem> storesList;

  @override
  StoreItem selectedStore;

  @override
  ProductItem selectedProduct;
}

ProductPageState initState(Map<String, dynamic> args) {
  return ProductPageState();
}
