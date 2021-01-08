import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:dosparkles/models/app_user.dart';

abstract class GlobalBaseState {
  Locale get locale;
  set locale(Locale locale);

  AppUser get user;
  set user(AppUser u);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Locale locale;

  @override
  AppUser user;

  @override
  GlobalState clone() {
    return GlobalState()
      ..locale = locale
      ..user = user;
  }
}
