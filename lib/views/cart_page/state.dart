import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:com.floridainc.dosparkles/globalbasestate/state.dart';
import 'package:com.floridainc.dosparkles/models/models.dart';

class CartPageState implements GlobalBaseState, Cloneable<CartPageState> {
  AnimationController animationController;

  @override
  CartPageState clone() {
    return CartPageState()
      ..animationController = animationController 
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
   List<CartItem> shoppingCart;
}

CartPageState initState(Map<String, dynamic> args) {
  return CartPageState();
}
