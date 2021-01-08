import 'package:dosparkles/globalbasestate/action.dart';
import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/models/app_user.dart';
import 'package:dosparkles/utils/general.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dosparkles/actions/api/graphql_client.dart';
import 'package:dosparkles/models/model_factory.dart';
import 'package:dosparkles/models/models.dart';

class StoresInfoOperate {
  static Future whenAppStart() async {
    print("whenAppStart StoresInfo");
    final storesRequest = await BaseGraphQLClient.instance.storesWithProductsList();
    printWrapped(storesRequest.data['stores'].toString());
    // GlobalStore.store.dispatch(GlobalActionCreator.setStoresList(AppUser.fromJson(meRequest.data['me']['user'])));
    // ModelFactory.generate<AppUser>
  }
}
