import 'dart:convert' show json;
import 'package:dosparkles/actions/app_config.dart';

class AppUser {
  String name;

  String email;

  String country;

  String avatarUrl;

  AppUser.fromParams({this.name, this.email, this.country, this.avatarUrl});

  factory AppUser(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new AppUser.fromJson(json.decode(jsonStr))
          : new AppUser.fromJson(jsonStr);

  AppUser.fromJson(jsonRes) {
    name = jsonRes['name'];
    email = jsonRes['email'];
    country = jsonRes['country'];

    avatarUrl = jsonRes['avatar'] != null ? AppConfig.instance.baseApiHost + jsonRes['avatar']['url'] : null;
  }
  @override
  String toString() {
    return '{"name": "$name","email": ${email != null ? '${json.encode(email)}' : 'null'}}';
  }
}
