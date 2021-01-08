import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/app_user.dart';

class CartPageState
    implements GlobalBaseState, Cloneable<CartPageState> {
  AnimationController animationController;

  @override
  CartPageState clone() {
    return CartPageState()..animationController = animationController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

CartPageState initState(Map<String, dynamic> args) {
  return CartPageState();
}
