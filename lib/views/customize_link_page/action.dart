import 'package:fish_redux/fish_redux.dart';

import 'package:com.floridainc.dosparkles/models/models.dart';

enum CustomizeLinkPageAction { action }

class CustomizeLinkPageActionCreator {
  static Action onAction() {
    return const Action(CustomizeLinkPageAction.action);
  }
}
