import 'package:dosparkles/globalbasestate/action.dart';
import 'package:dosparkles/globalbasestate/store.dart';
import 'package:dosparkles/models/models.dart';
import 'package:dosparkles/utils/general.dart';
import 'package:dosparkles/actions/api/graphql_client.dart';
import 'package:dosparkles/models/model_factory.dart';

class StoresInfoOperate {
  static Future whenAppStart() async {
    final storesRequest =
        await BaseGraphQLClient.instance.storesWithProductsList();

    List<StoreItem> storesList = List.empty(growable: true);

    printWrapped('stores data raw: ${storesRequest.data['stores']}');
    
    for (var i = 0; i < storesRequest.data['stores'].length; i++) {
      printWrapped('store: ${storesRequest.data['stores'][i]}');
      StoreItem _store =
          ModelFactory.generate<StoreItem>(storesRequest.data['stores'][i]);
      storesList.add(_store);
    }

    printWrapped('storesList: ${storesList.toString()}');

    GlobalStore.store.dispatch(GlobalActionCreator.setStoresList(storesList));
  }
}
