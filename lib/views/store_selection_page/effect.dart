import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:dosparkles/models/models.dart';

import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/globalbasestate/action.dart';

import 'action.dart';
import 'state.dart';

Effect<StoreSelectionPageState> buildEffect() {
  return combineEffects(<Object, Effect<StoreSelectionPageState>>{
    StoreSelectionPageAction.action: _onAction,
    StoreSelectionPageAction.storeSelected: _onStoreSelected,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

void _onInit(Action action, Context<StoreSelectionPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
}

void _onBuild(Action action, Context<StoreSelectionPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<StoreSelectionPageState> ctx) {
  ctx.state.animationController.dispose();
}

void _onAction(Action action, Context<StoreSelectionPageState> ctx) {}

void _onStoreSelected(
    Action action, Context<StoreSelectionPageState> ctx) async {
  StoreItem store = action.payload;
  GlobalStore.store.dispatch(GlobalActionCreator.setSelectedStore(store));

  await Navigator.of(ctx.context).pushReplacementNamed('storepage');
}