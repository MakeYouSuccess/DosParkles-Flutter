import 'package:dosparkles/actions/app_config.dart';
import 'request.dart';

class BaseApi {
  BaseApi._();
  static final BaseApi _instance = BaseApi._();
  static BaseApi get instance => _instance;

  final Request _http = Request(AppConfig.instance.baseApiHost);

  // Future<ResponseModel<dynamic>> updateUser(String uid, String email,
  //     String photoUrl, String userName, String phone) async {
  //   final String _url = '/Users';
  //   final _data = {
  //     "phone": phone,
  //     "email": email,
  //     "photoUrl": photoUrl,
  //     "userName": userName,
  //     "uid": uid
  //   };
  //   return await _http.request(_url, method: "POST", data: _data);
  // }
}
