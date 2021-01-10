import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:dosparkles/models/models.dart';

abstract class GlobalBaseState {
  Locale get locale;
  set locale(Locale locale);

  AppUser get user;
  set user(AppUser u);

  List<StoreItem> get storesList;
  set storesList(List<StoreItem> s);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Locale locale;

  @override
  AppUser user;

  @override
  List<StoreItem> storesList;

  @override
  GlobalState clone() {
    return GlobalState()
      ..locale = locale
      ..user = user
      ..storesList = storesList;
  }
}
