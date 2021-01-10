import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dosparkles/actions/adapt.dart';
import 'package:dosparkles/style/themestyle.dart';
import 'package:dosparkles/utils/colors.dart';
import 'package:dosparkles/widgets/sparkles_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StorePageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _MainBody(
          animationController: state.animationController,
          dispatch: dispatch,
        ),
      ],
    ),
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _AppBar(title: state.selectedStore.name)),
    drawer: SparklesDrawer(),
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
  final String title;

  const _AppBar({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(title)),
      flexibleSpace: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                HexColor('#3D9FB0'),
                HexColor('#557084'),
              ],
              begin: const FractionalOffset(0.5, 0.5),
              end: const FractionalOffset(0.5, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
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
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
