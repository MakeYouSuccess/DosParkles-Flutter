// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:dosparkles/models/base_api_model/user_premium_model.dart';

class AppUser {
  // FirebaseUser firebaseUser;
  String name;

  // UserPremiumData premium;
  // bool get isPremium => premium?.expireDate == null
  //     ? false
  //     : DateTime.parse(premium.expireDate).compareTo(DateTime.now()) > 0;
  AppUser({this.name});
}
