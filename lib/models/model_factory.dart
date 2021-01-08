import 'models.dart';
class ModelFactory {
  static T generate<T>(json) {
    switch (T.toString()) {
      case 'AppUser':
        return AppUser(json) as T;
      default:
        return json;
    }
  }
}
