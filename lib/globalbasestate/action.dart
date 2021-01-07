import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:dosparkles/models/app_user.dart';

enum GlobalAction { changeThemeColor, changeLocale, setUser, setUserPremium }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action changeLocale(Locale l) {
    return Action(GlobalAction.changeLocale, payload: l);
  }

  static Action setUser(AppUser user) {
    return Action(GlobalAction.setUser, payload: user);
  } 
}
