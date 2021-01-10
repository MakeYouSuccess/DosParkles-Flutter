import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:dosparkles/actions/user_info_operate.dart';
import 'package:dosparkles/actions/stores_info_operate.dart';

Effect<StartPageState> buildEffect() {
  return combineEffects(<Object, Effect<StartPageState>>{
    StartPageAction.action: _onAction,
    StartPageAction.onStart: _onStart,
    Lifecycle.build: _onBuild,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<StartPageState> ctx) {}

Future _loadData() async {
  await UserInfoOperate.whenAppStart();
  await StoresInfoOperate.whenAppStart();
}

void _onInit(Action action, Context<StartPageState> ctx) async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.setAutoInitEnabled(true);

  ctx.state.pageController = PageController();

  await _loadData();

  SharedPreferences.getInstance().then((_p) async {
    final _isFirst = _p.getBool('firstStart') ?? true;
    if (!_isFirst) {
      await _pushToSignInPage(ctx.context);
    } else
      ctx.dispatch(StartPageActionCreator.setIsFirst(_isFirst));
  });
}

void _onDispose(Action action, Context<StartPageState> ctx) {
  ctx.state.pageController.dispose();
}

void _onBuild(Action action, Context<StartPageState> ctx) {}

void _onStart(Action action, Context<StartPageState> ctx) async {
  SharedPreferences.getInstance().then((_p) {
    _p.setBool('firstStart', false);
  });
  await _pushToSignInPage(ctx.context);
}

Future _pushToSignInPage(BuildContext context) async {
  await Navigator.of(context).pushReplacementNamed('loginpage');
}