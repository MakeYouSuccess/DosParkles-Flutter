import 'package:dosparkles/globalbasestate/action.dart';
import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/base_api.dart';

class UserInfoOperate {
  static bool isPremium = false;
  static String premiumExpireDate;

  static Future whenLogin(AppUser user, String nickName) async {
    final _baseApi = BaseApi.instance;
    // _baseApi.updateUser(
    //     user.uid, user.email, user.photoUrl, nickName, user.phoneNumber);

    GlobalStore.store
        .dispatch(GlobalActionCreator.setUser(AppUser(name: "test")));
  }

  static Future<bool> whenLogout() async {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final FirebaseUser currentUser = await _auth.currentUser();
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    // if (currentUser != null) {
    try {
      // _auth.signOut();
      _preferences.remove('PaymentToken');
      _preferences.remove('premiumData');
      premiumExpireDate = null;
      GlobalStore.store.dispatch(GlobalActionCreator.setUser(null));
    } on Exception catch (_) {
      return false;
    }
    return true;
    // }
    // return false;
  }

  static Future whenAppStart() async {
    print("whenAppStart");
    // var _user = await FirebaseAuth.instance.currentUser();
    // if (_user != null) {
    //   SharedPreferences _preferences = await SharedPreferences.getInstance();
    //   UserPremiumData _premiumData;
    //   String _data = _preferences.getString('premiumData');
    //   if (_data != null) _premiumData = UserPremiumData(_data);
    //   GlobalStore.store.dispatch(GlobalActionCreator.setUser(
    //       AppUser(firebaseUser: _user, premium: _premiumData)));
    // }
  }
}
