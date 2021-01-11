import 'dart:convert' show json;
import 'package:dosparkles/actions/app_config.dart';
import 'package:flutter/material.dart';
import 'package:dosparkles/utils/general.dart';

class ProductItem {
  String id;

  String name;

  String shineonId;

  String thumbnailUrl;

  String videoUrl;

  double oldPrice;

  double price;

  bool showOldPrice;

  bool engraveAvailable;

  dynamic properties;

  double engraveOldPrice;

  double engravePrice;

  bool showOldEngravePrice;

  String defaultFinishMaterial;

  String optionalFinishMaterial;

  double optionalFinishMaterialPrice;

  bool optionalFinishMaterialEnabled;

  List<dynamic> mediaUrls;

  String deliveryInformation;

  double weight;

  bool uploadsAvailable;

  bool sizeOptionsAvailable;

  bool isActive;

  ProductItem.fromParams(
      {this.id,
      this.name,
      this.shineonId,
      this.thumbnailUrl,
      this.videoUrl,
      this.oldPrice,
      this.price,
      this.showOldPrice,
      this.engraveAvailable,
      this.properties,
      this.engraveOldPrice,
      this.engravePrice,
      this.showOldEngravePrice,
      this.defaultFinishMaterial,
      this.optionalFinishMaterial,
      this.optionalFinishMaterialPrice,
      this.optionalFinishMaterialEnabled,
      this.mediaUrls,
      this.deliveryInformation,
      this.weight,
      this.uploadsAvailable,
      this.sizeOptionsAvailable,
      this.isActive});

  factory ProductItem(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new ProductItem.fromJson(json.decode(jsonStr))
          : new ProductItem.fromJson(jsonStr);

  ProductItem.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    shineonId = jsonRes['shineonId'];
    thumbnailUrl = jsonRes['thumbnail'] != null
        ? AppConfig.instance.baseApiHost + jsonRes['thumbnail']['url']
        : null;

    videoUrl = jsonRes['video'] != null
        ? AppConfig.instance.baseApiHost + jsonRes['video']['url']
        : null;

    oldPrice = checkDouble(jsonRes['oldPrice']);
    price = checkDouble(jsonRes['price']);
    showOldPrice = jsonRes['showOldPrice'];
    engraveAvailable = jsonRes['engraveAvailable'];

    properties = jsonRes['properties'];

    engraveOldPrice = checkDouble(jsonRes['engraveOldPrice']);
    engravePrice = checkDouble(jsonRes['engravePrice']);
    showOldEngravePrice = jsonRes['showOldEngravePrice'];

    defaultFinishMaterial = jsonRes['defaultFinishMaterial'];
    optionalFinishMaterial = jsonRes['optionalFinishMaterial'];

    optionalFinishMaterialPrice =
        checkDouble(jsonRes['optionalFinishMaterialPrice']);
    optionalFinishMaterialEnabled = jsonRes['optionalFinishMaterialEnabled'];

    mediaUrls = jsonRes['media']
        .map((item) => AppConfig.instance.baseApiHost + item['url'].toString())
        .toList();

    deliveryInformation = jsonRes['deliveryInformation'];
    weight = checkDouble(jsonRes['weight']);
    uploadsAvailable = jsonRes['uploadsAvailable'];
    sizeOptionsAvailable = jsonRes['sizeOptionsAvailable'];
    isActive = jsonRes['isActive'];
  }
  @override
  String toString() {
    return '{"name": "$name","id": "$id"}';
  }
}
