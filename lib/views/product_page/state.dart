import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/app_user.dart';

class ProductPageState
    implements GlobalBaseState, Cloneable<ProductPageState> {
  AnimationController animationController;

  @override
  ProductPageState clone() {
    return ProductPageState()..animationController = animationController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

ProductPageState initState(Map<String, dynamic> args) {
  return ProductPageState();
}
