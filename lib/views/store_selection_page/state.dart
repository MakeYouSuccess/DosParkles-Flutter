import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:dosparkles/globalbasestate/state.dart';
import 'package:dosparkles/models/app_user.dart';

class StoreSelectionPageState
    implements GlobalBaseState, Cloneable<StoreSelectionPageState> {
  AnimationController animationController;

  @override
  StoreSelectionPageState clone() {
    return StoreSelectionPageState()..animationController = animationController;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

StoreSelectionPageState initState(Map<String, dynamic> args) {
  return StoreSelectionPageState();
}
