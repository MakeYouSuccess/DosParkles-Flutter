import 'package:fish_redux/fish_redux.dart';

enum LoginPageAction {
  action,
  loginclicked,
  signUp,
  googleSignIn,
  facebookSignIn
}

class LoginPageActionCreator {
  static Action onAction() {
    return const Action(LoginPageAction.action);
  }

  static Action onLoginClicked() {
    return const Action(LoginPageAction.loginclicked);
  }

  static Action onSignUp() {
    return const Action(LoginPageAction.signUp);
  }

  static Action onGoogleSignIn() {
    return const Action(LoginPageAction.googleSignIn);
  }

   static Action onFacebookSignIn() {
    return const Action(LoginPageAction.facebookSignIn);
  }
}
