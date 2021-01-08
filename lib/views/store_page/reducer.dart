import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StorePageState> buildReducer() {
  return asReducer(
    <Object, Reducer<StorePageState>>{
      StorePageAction.action: _onAction,
    },
  );
}

StorePageState _onAction(StorePageState state, Action action) {
  final StorePageState newState = state.clone();
  return newState;
}