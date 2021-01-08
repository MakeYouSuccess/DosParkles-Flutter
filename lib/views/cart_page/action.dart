import 'package:fish_redux/fish_redux.dart';

enum CartPageAction {
  action
}

class CartPageActionCreator {
  static Action onAction() {
    return const Action(CartPageAction.action);
  }
}
