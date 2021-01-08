import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/app_user.dart';

class StorePageState
    implements GlobalBaseState, Cloneable<StorePageState> {
  AnimationController animationController;

  @override
  StorePageState clone() {
    return StorePageState()..animationController = animationController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

StorePageState initState(Map<String, dynamic> args) {
  return StorePageState();
}
