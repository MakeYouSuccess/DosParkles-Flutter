import 'models.dart';

class ModelFactory {
  static T generate<T>(json) {
    switch (T.toString()) {
      // case 'VideoListModel':
      //   return VideoListModel(json) as T;
      default:
        return json;
    }
  }
}
