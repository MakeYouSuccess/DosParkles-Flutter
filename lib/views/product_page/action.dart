import 'package:fish_redux/fish_redux.dart';

enum ProductPageAction { action, goToCart, addToCart, backToProduct }

class ProductPageActionCreator {
  static Action onAction() {
    return const Action(ProductPageAction.action);
  }

  static Action onGoToCart() {
    return const Action(ProductPageAction.goToCart);
  }

  static Action onAddToCart() {
    return const Action(ProductPageAction.addToCart);
  }

  static Action onBackToProduct() {
    return const Action(ProductPageAction.backToProduct);
  }
}
