import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/models.dart';
class StoreSelectionPageState
    implements GlobalBaseState, Cloneable<StoreSelectionPageState> {
  AnimationController animationController;

  @override
  StoreSelectionPageState clone() {
    return StoreSelectionPageState()..animationController = animationController;
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

StoreSelectionPageState initState(Map<String, dynamic> args) {
  return StoreSelectionPageState();
}
