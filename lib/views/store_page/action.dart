import 'package:dosparkles/models/models.dart';
import 'package:fish_redux/fish_redux.dart';

enum StorePageAction {
  action,
  productSelected,
  backToAllProducts,
  nextProduct,
  prevProduct
}

class StorePageActionCreator {
  static Action onAction() {
    return const Action(StorePageAction.action);
  }
  
  static Action onProductSelected(ProductItem product) {
    return Action(StorePageAction.productSelected, payload: product);
  }

  static Action onBackToAllProducts() {
    return const Action(StorePageAction.backToAllProducts);
  }

  static Action onNextProduct() {
    return const Action(StorePageAction.nextProduct);
  }

  static Action onPrevProduct() {
    return const Action(StorePageAction.prevProduct);
  }
}
