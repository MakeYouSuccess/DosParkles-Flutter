import 'package:dosparkles/utils/general.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dosparkles/actions/adapt.dart';
import 'package:dosparkles/utils/colors.dart';
import 'package:dosparkles/models/models.dart';
import 'package:dosparkles/widgets/sparkles_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StoreSelectionPageState state, Dispatch dispatch, ViewService viewService) {
  Adapt.initContext(viewService.context);
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _MainBody(
            animationController: state.animationController,
            dispatch: dispatch,
            stores: state.storesList),
        _AppBar(),
      ],
    ),
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
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: HexColor('#01406F'),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(AppLocalizations.of(context).storeSelectionPageTitle)),
    );
  }
}

class _MainBody extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  final List<StoreItem> stores;

  const _MainBody({
    this.animationController,
    this.dispatch,
    this.stores,
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
    const Key centerKey = ValueKey('bottom-sliver-list');

    printWrapped('stores ${stores.toString()}');

    return Center(
      child: SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: Adapt.px(200)),
            Flexible(
              child: CustomScrollView(
                center: centerKey,
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverList(
                    key: centerKey,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 2.0),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.grey,
                              height: 100,
                              child: Text('Store: ${stores[index].name}'),
                            ));
                      },
                      childCount: stores.length,
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
