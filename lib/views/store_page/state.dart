import 'dart:ui';
import 'package:dosparkles/utils/general.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/models.dart';
import 'package:flutter/material.dart';

class StorePageState implements GlobalBaseState, Cloneable<StorePageState> {
  AnimationController animationController;
  bool listView;
  int productIndex;

  @override
  StorePageState clone() {
    return StorePageState()
      ..animationController = animationController
      ..listView = listView
      ..productIndex = productIndex
      //
      ..locale = locale
      ..user = user
      ..storesList = storesList
      ..selectedStore = selectedStore
      ..selectedProduct = selectedProduct
      ..shoppingCart = shoppingCart;
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

  @override
  Map<ProductItem, int> shoppingCart;
}

StorePageState initState(Map<String, dynamic> args) {
  print('StorePageState, initState, args: $args');
  StorePageState state = StorePageState();
  state.listView = true;
  if (args != null) {
    if (args['listView'] != null) {
      state.listView = args['listView'];
    }
  }

  return state;
}
