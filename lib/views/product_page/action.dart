import 'package:fish_redux/fish_redux.dart';

enum ProductPageAction {
  action
}

class ProductPageActionCreator {
  static Action onAction() {
    return const Action(ProductPageAction.action);
  }
}
