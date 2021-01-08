import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:dosparkles/models/app_user.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
    },
  );
}

GlobalState _onChangeLocale(GlobalState state, Action action) {
  final Locale l = action.payload;
  return state.clone()..locale = l;
}

GlobalState _onSetUser(GlobalState state, Action action) {
  final AppUser user = action.payload;
  return state.clone()..user = user;
}
