import 'package:fish_redux/fish_redux.dart';

enum StorePageAction {
  action
}

class StorePageActionCreator {
  static Action onAction() {
    return const Action(StorePageAction.action);
  }
}
