import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dosparkles/actions/app_config.dart';
import 'package:dosparkles/actions/api/graphql_service.dart';
// import 'package:dosparkles/models/base_api_model/base_cast_list.dart';
// import 'package:dosparkles/models/base_api_model/cast_list_detail.dart';

class BaseGraphQLClient {
  BaseGraphQLClient._();

  static final BaseGraphQLClient _instance = BaseGraphQLClient._();
  static BaseGraphQLClient get instance => _instance;
  final GraphQLService _service = GraphQLService()
    ..setupClient(
      httpLink: AppConfig.instance.graphQLHttpLink,
      // webSocketLink: AppConfig.instance.graphQlWebSocketLink
    );

  void setToken(String token) {
    print('setToken');
    _service.setupClient(
        httpLink: AppConfig.instance.graphQLHttpLink,
        /*webSocketLink: null, */ token: token);
  }

  void removeToken() {
    print('removeToken');
    _service.setupClient(
      httpLink: AppConfig.instance.graphQLHttpLink, /*webSocketLink: null*/
    );
  }

  Future<QueryResult> loginWithEmail(String email, String password) {
    String _query = '''
    mutation {
      login(input: {
        identifier: "$email",
        password: "$password"
      }){
        user{
          id
          username
          email
          role {
            name
            type
            description
          }
        }
        jwt
      }
    }
    ''';

    return _service.mutate(_query);
  }

  Future<QueryResult> me() {
    String _query = '''
    query {
      me {
          id
          user {
            email
            username
            role {
              id
              name
            }
            name
            country
          }
        }
      }
    ''';

    return _service.query(_query);
  }

  // Stream<FetchResult> tvShowCommentSubscription(int id) {
  //   String _sub = '''
  //   subscription tvComment{
  //      comment: tvShowCommentList(id:$id){
  //         id
  //         comment
  //       }
  //   }''';

  //   return _service.subscribe(_sub, operationName: 'tvComment');
  // }
}
