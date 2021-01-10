import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/models.dart';

class CartPageState implements GlobalBaseState, Cloneable<CartPageState> {
  AnimationController animationController;

  @override
  CartPageState clone() {
    return CartPageState()..animationController = animationController;
  }


  @override
  Locale locale;

  @override
  AppUser user;

  @override
  List<StoreItem> storesList;
}

CartPageState initState(Map<String, dynamic> args) {
  return CartPageState();
}
