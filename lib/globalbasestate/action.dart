import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:dosparkles/models/models.dart';

enum GlobalAction { changeLocale, setUser, setStoresList, setSelectedStore, setSelectedProduct }

class GlobalActionCreator {

  static Action changeLocale(Locale l) {
    return Action(GlobalAction.changeLocale, payload: l);
  }

  static Action setUser(AppUser user) {
    return Action(GlobalAction.setUser, payload: user);
  } 

  static Action setStoresList(List<StoreItem> storesList) {
    return Action(GlobalAction.setStoresList, payload: storesList);
  } 

  static Action setSelectedStore(StoreItem store) {
    return Action(GlobalAction.setSelectedStore, payload: store);
  } 

  static Action setSelectedProduct(ProductItem product) {
    return Action(GlobalAction.setSelectedProduct, payload: product);
  } 
}
