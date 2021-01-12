import 'package:fish_redux/fish_redux.dart';

import 'package:dosparkles/models/models.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProductPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProductPageState>>{
      ProductPageAction.action: _onAction,
      ProductPageAction.setOptionMaterialSelected: _onSetOptionMaterialSelected,
      ProductPageAction.setEngravingInputs: _onSetEngravingInputs,
      ProductPageAction.setProductCount: _onSetProductCount,
    },
  );
}

ProductPageState _onAction(ProductPageState state, Action action) {
  final ProductPageState newState = state.clone();
  return newState;
}

ProductPageState _onSetOptionMaterialSelected(
    ProductPageState state, Action action) {
  final ProductPageState newState = state.clone();
  print('action.payload ${action.payload}');
  newState.optionalMaterialSelected = action.payload;
  return newState;
}

ProductPageState _onSetEngravingInputs(ProductPageState state, Action action) {
  final ProductPageState newState = state.clone();
  newState.engraveInputs = action.payload;
  return newState;
}

ProductPageState _onSetProductCount(ProductPageState state, Action action) {
  final ProductPageState newState = state.clone();
  newState.productQuantity = action.payload;
  return newState;
}
