import 'package:dosparkles/models/models.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;

import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/globalbasestate/action.dart';

import 'action.dart';
import 'state.dart';

Effect<StorePageState> buildEffect() {
  return combineEffects(<Object, Effect<StorePageState>>{
    StorePageAction.action: _onAction,
    StorePageAction.addToCart: onAddToCart,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

void _onInit(Action action, Context<StorePageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state..listView = true;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
}

void _onBuild(Action action, Context<StorePageState> ctx) {
  // Future.delayed(Duration(milliseconds: 150),
  //     () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<StorePageState> ctx) {
  ctx.state.animationController.dispose();
}

void _onAction(Action action, Context<StorePageState> ctx) {}

void onAddToCart(Action action, Context<StorePageState> ctx) {}
