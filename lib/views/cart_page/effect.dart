import 'package:com.floridainc.dosparkles/models/cart_item_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;

import 'package:com.floridainc.dosparkles/globalbasestate/store.dart';
import 'package:com.floridainc.dosparkles/globalbasestate/action.dart';

import 'action.dart';
import 'state.dart';

Effect<CartPageState> buildEffect() {
  return combineEffects(<Object, Effect<CartPageState>>{
    CartPageAction.action: _onAction,
    CartPageAction.setProductCount: _onSetProductCount,
    CartPageAction.removeCartItem: _onRemoveCartItem,
    CartPageAction.proceedToCheckout: _onProceedToCheckout,
    CartPageAction.backToProduct: _onBackToProduct,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
  });
}

void _onInit(Action action, Context<CartPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
}

void _onBuild(Action action, Context<CartPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<CartPageState> ctx) {
  ctx.state.animationController.dispose();
}

void _onAction(Action action, Context<CartPageState> ctx) {}

void _onSetProductCount(Action action, Context<CartPageState> ctx) {
  CartItem cartItem = action.payload[0];
  int count = action.payload[1];

  print('cart: ${ctx.state.shoppingCart.toString()}');

  for (var i = 0; i < ctx.state.shoppingCart.length; i++) {
    if (ctx.state.shoppingCart[i] == cartItem) {
      double basePrice =
          ctx.state.shoppingCart[i].amount / ctx.state.shoppingCart[i].count;
      ctx.state.shoppingCart[i].count = count;
      ctx.state.shoppingCart[i].amount = basePrice * count;
      break;
    }
  }

  ctx.dispatch(
      CartPageActionCreator.onSetProductCountUpdate(ctx.state.shoppingCart));

  GlobalStore.store
      .dispatch(GlobalActionCreator.setShoppingCart(ctx.state.shoppingCart));
}

void _onRemoveCartItem(Action action, Context<CartPageState> ctx) {
  CartItem cartItem = action.payload;

  ctx.state.shoppingCart.removeWhere((element) => element == cartItem);

  GlobalStore.store
      .dispatch(GlobalActionCreator.setShoppingCart(ctx.state.shoppingCart));

  ctx.dispatch(
      CartPageActionCreator.onSetProductCountUpdate(ctx.state.shoppingCart));

  if (ctx.state.shoppingCart.length == 0) {
    Navigator.of(ctx.context)
        .pushReplacementNamed('storepage', arguments: {'listView': true});
  }
}

void _onProceedToCheckout(Action action, Context<CartPageState> ctx) {
  Navigator.of(ctx.context)
      .pushReplacementNamed('storepage', arguments: {'listView': true});
}

void _onBackToProduct(Action action, Context<CartPageState> ctx) async {
  Navigator.of(ctx.context)
      .pushReplacementNamed('storepage', arguments: {'listView': false});
}