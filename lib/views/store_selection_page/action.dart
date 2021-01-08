import 'package:fish_redux/fish_redux.dart';

enum StoreSelectionPageAction {
  action
}

class StoreSelectionPageActionCreator {
  static Action onAction() {
    return const Action(StoreSelectionPageAction.action);
  }
}
