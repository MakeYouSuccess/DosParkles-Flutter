import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dosparkles/actions/adapt.dart';
import 'package:dosparkles/style/themestyle.dart';
import 'package:dosparkles/utils/colors.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ProductPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _MainBody(
          animationController: state.animationController,
          dispatch: dispatch,
        ),
        _AppBar(),
      ],
    ),
  );
}

class _BackGround extends StatelessWidget {
  final AnimationController controller;
  const _BackGround({this.controller});
  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);

    return Column(children: [
      Expanded(child: SizedBox()),
    ]);
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

class _EmailEntry extends StatelessWidget {
  final AnimationController controller;
  final TextEditingController accountTextController;
  final TextEditingController passWordTextController;
  final FocusNode accountFocusNode;
  final FocusNode pwdFocusNode;
  final Function(String) onSubmit;
  const _EmailEntry(
      {this.controller,
      this.accountFocusNode,
      this.pwdFocusNode,
      this.accountTextController,
      this.passWordTextController,
      this.onSubmit});
  @override
  Widget build(BuildContext context) {
    final accountCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.ease,
      ),
    );
    final passwordCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.ease,
      ),
    );
    final _theme = ThemeStyle.getTheme(context);

    return Column(children: [
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(accountCurve),
        child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(accountCurve),
            child: Padding(
              padding: EdgeInsets.all(Adapt.px(40)),
              child: TextField(
                focusNode: accountFocusNode,
                controller: accountTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: Adapt.px(35)),
                cursorColor: _theme.iconTheme.color,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'email',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black87))),
                onSubmitted: (s) {
                  accountFocusNode.nextFocus();
                },
              ),
            )),
      ),
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(passwordCurve),
        child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(passwordCurve),
          child: Padding(
            padding: EdgeInsets.all(Adapt.px(40)),
            child: TextField(
              focusNode: pwdFocusNode,
              controller: passWordTextController,
              style: TextStyle(fontSize: Adapt.px(35)),
              cursorColor: _theme.iconTheme.color,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'password',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black87))),
              onSubmitted: onSubmit,
            ),
          ),
        ),
      ),
    ]);
  }
}

class _SubmitButton extends StatelessWidget {
  final AnimationController controller;
  final Function onSubimt;
  const _SubmitButton({this.controller, this.onSubimt});
  @override
  Widget build(BuildContext context) {
    final submitWidth = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    final loadCurved = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.ease,
      ),
    );
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, w) {
        double buttonWidth = Adapt.screenW() * 0.8;
        return Container(
          margin: EdgeInsets.only(top: Adapt.px(60)),
          height: Adapt.px(100),
          child: Stack(
            children: <Widget>[
              Container(
                height: Adapt.px(100),
                width: Tween<double>(begin: buttonWidth, end: Adapt.px(100))
                    .animate(submitWidth)
                    .value,
                child: FlatButton(
                  color: HexColor("#182465"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.px(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: onSubimt,
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(loadCurved),
                child: Container(
                  width: Adapt.px(100),
                  height: Adapt.px(100),
                  padding: EdgeInsets.all(Adapt.px(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _MainBody extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  const _MainBody({
    this.animationController,
    this.dispatch,
  });
  @override
  Widget build(BuildContext context) {
    final cardCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0,
        0.4,
        curve: Curves.ease,
      ),
    );
    final submitCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.ease,
      ),
    );

    return Center(
      child: SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.screenH() / 2,
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ],
            ),
          ),
        ),
      ),
    );
  }
}