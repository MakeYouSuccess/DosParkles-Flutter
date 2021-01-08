import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CartPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<CartPageState>>{
      CartPageAction.action: _onAction,
    },
  );
}

CartPageState _onAction(CartPageState state, Action action) {
  final CartPageState newState = state.clone();
  return newState;
}