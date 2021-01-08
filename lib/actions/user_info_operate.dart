import 'package:dosparkles/globalbasestate/action.dart';
import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/models/model_factory.dart';
import 'package:dosparkles/models/models.dart';
import 'package:dosparkles/utils/general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dosparkles/actions/api/graphql_client.dart';

class UserInfoOperate {
  static Future whenLogin(String token) async {
    BaseGraphQLClient.instance.setToken(token);

    final meRequest = await BaseGraphQLClient.instance.me();
    final user = ModelFactory.generate<AppUser>(meRequest.data['me']['user']);
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(user));

    printWrapped('user whenLogin: $user');
  }

  static Future<bool> whenLogout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.remove('jwt');
      _preferences.remove('userId');
      BaseGraphQLClient.instance.removeToken();
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));
    } on Exception catch (_) {
      return false;
    }
    return true;
  }

  static Future whenAppStart() async {
    print("whenAppStart UserInfo");
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    final savedToken = _preferences.getString('jwt') ?? '';
    print('savedToken $savedToken');

    if (savedToken.isNotEmpty) {
      whenLogin(savedToken);
    }
  }
}
