import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StorePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<StorePageState>>{
      StorePageAction.action: _onAction,
      StorePageAction.productIndexSelected: onProductIndexSelected,
      StorePageAction.backToAllProducts: onBackToAllProducts,
    },
  );
}

StorePageState _onAction(StorePageState state, Action action) {
  final StorePageState newState = state.clone();
  return newState;
}

StorePageState onProductIndexSelected(StorePageState state, Action action) {
  int productIndex = action.payload;

  final StorePageState newState = state.clone();
  newState.listView = false;
  newState.productIndex = productIndex;
  return newState;
}

StorePageState onBackToAllProducts(StorePageState state, Action action) {
  final StorePageState newState = state.clone();
  newState.listView = true;
  return newState;
}
