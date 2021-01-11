import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:dosparkles/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeLocale: _onChangeLocale,
      GlobalAction.setUser: _onSetUser,
      GlobalAction.setStoresList: _onSetStoresList,
      GlobalAction.setSelectedStore: _setSelectedStore,
      GlobalAction.setSelectedProduct: _setSelectedProduct,
      GlobalAction.setShoppingCart: _setShoppingCart,
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

GlobalState _onSetStoresList(GlobalState state, Action action) {
  final List<StoreItem> storesList = action.payload;
  return state.clone()..storesList = storesList;
}

GlobalState _setSelectedStore(GlobalState state, Action action) {
  final StoreItem store = action.payload;
  return state.clone()..selectedStore = store;
}

GlobalState _setSelectedProduct(GlobalState state, Action action) {
  final ProductItem product = action.payload;
  return state.clone()..selectedProduct = product;
}

GlobalState _setShoppingCart(GlobalState state, Action action) {
  final Map<ProductItem, int> cart = action.payload;
  return state.clone()..shoppingCart = cart;
}



