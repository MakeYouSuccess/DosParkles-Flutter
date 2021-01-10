import 'dart:convert' show json;
import 'package:dosparkles/utils/general.dart';

import 'product_item.dart';
import 'model_factory.dart';
import 'package:dosparkles/actions/app_config.dart';

class StoreItem {
  String id;

  String name;

  List<ProductItem> products;

  String address;

  String phone;

  String thumbnail;

  StoreItem.fromParams(
      {this.id,
      this.name,
      this.products,
      this.address,
      this.phone,
      this.thumbnail});

  factory StoreItem(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new StoreItem.fromJson(json.decode(jsonStr))
          : new StoreItem.fromJson(jsonStr);

  StoreItem.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    address = jsonRes['address'];
    phone = jsonRes['phone'];
    thumbnail = jsonRes['thumbnail'] != null
        ? AppConfig.instance.baseApiHost + jsonRes['thumbnail']['url']
        : null;

    if (jsonRes['products'] != null) {
      List<ProductItem> _products = List.empty(growable: true);

      for (var i = 0; i < jsonRes['products'].length; i++) {
        printWrapped('product: ${jsonRes['products'][i].toString()}');
        ProductItem _productItem =
            ModelFactory.generate<ProductItem>(jsonRes['products'][i]);
        _products.add(_productItem);
      }

      products = _products;
    } else {
      products = List.empty();
    }
  }
  @override
  String toString() {
    return '{"id": "$id", "name": "$name"}';
  }
}
