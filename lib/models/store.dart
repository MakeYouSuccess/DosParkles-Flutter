import 'dart:convert' show json;
import 'package:dosparkles/actions/app_config.dart';

class Store {
  String name;

  String email;

  String country;

  String avatarUrl;

  Store.fromParams({this.name, this.email, this.country, this.avatarUrl});

  factory Store(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Store.fromJson(json.decode(jsonStr))
          : new Store.fromJson(jsonStr);

  Store.fromJson(jsonRes) {
    name = jsonRes['name'];
    email = jsonRes['email'];
    country = jsonRes['country'];
    avatarUrl = AppConfig.instance.baseApiHost + jsonRes['avatar']['url'];
  }
  @override
  String toString() {
    return '{"name": "$name"}';
  }
}
