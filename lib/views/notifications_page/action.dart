import 'package:fish_redux/fish_redux.dart';

import 'package:com.floridainc.dosparkles/models/models.dart';

enum NotificationsPageAction { action }

class NotificationsPageActionCreator {
  static Action onAction() {
    return const Action(NotificationsPageAction.action);
  }
}