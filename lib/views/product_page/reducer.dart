import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProductPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProductPageState>>{
      ProductPageAction.action: _onAction,
    },
  );
}

ProductPageState _onAction(ProductPageState state, Action action) {
  final ProductPageState newState = state.clone();
  return newState;
}