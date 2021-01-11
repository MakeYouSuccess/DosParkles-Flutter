import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:dosparkles/models/models.dart';

import 'action.dart';
import 'state.dart';

Effect<ProductPageState> buildEffect() {
  return combineEffects(<Object, Effect<ProductPageState>>{
    ProductPageAction.action: _onAction,
    ProductPageAction.goToCart: _onGoToCart,
    ProductPageAction.addToCart: _onAddToCart,
    ProductPageAction.backToProduct: _onBackToProduct,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onInit(Action action, Context<ProductPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
}

void _onBuild(Action action, Context<ProductPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<ProductPageState> ctx) {
  ctx.state.animationController.dispose();
}

void _onGoToCart(Action action, Context<ProductPageState> ctx) async {
  //
  Navigator.of(ctx.context).pushReplacementNamed('cartpage');
}

void _onAddToCart(Action action, Context<ProductPageState> ctx) async {
  ProductItem product = action.payload[0];
  int count = action.payload[1];
  // GlobalStore.store.dispatch(GlobalActionCreator.setSelectedProduct(product));

  Navigator.of(ctx.context).pushReplacementNamed('cartpage');
  //
}

void _onBackToProduct(Action action, Context<ProductPageState> ctx) async {
  Navigator.of(ctx.context)
      .pushReplacementNamed('storepage', arguments: {'listView': false});
}

void _onAction(Action action, Context<ProductPageState> ctx) {}
