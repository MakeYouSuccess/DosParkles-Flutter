import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dosparkles/actions/adapt.dart';
import 'package:dosparkles/style/themestyle.dart';
import 'package:dosparkles/utils/colors.dart';
import 'package:dosparkles/widgets/sparkles_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dosparkles/models/models.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dosparkles/widgets/touch_spin.dart';
import 'package:intl/intl.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ProductPageState state, Dispatch dispatch, ViewService viewService) {
  Adapt.initContext(viewService.context);
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _MainBody(
            animationController: state.animationController,
            dispatch: dispatch,
            selectedProduct: state.selectedProduct),
      ],
    ),
    appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _AppBar(
          shoppingCart: state.shoppingCart,
          dispatch: dispatch,
        )),
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
  final Map<ProductItem, int> shoppingCart;
  final Dispatch dispatch;

  const _AppBar({this.shoppingCart, this.dispatch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(AppLocalizations.of(context).productPageTitle)),
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
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  if (shoppingCart.length > 0) {
                    dispatch(ProductPageActionCreator.onGoToCart());
                  }
                },
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    shoppingCart.length == 0
                        ? new Container()
                        : new Positioned(
                            left: 5,
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                    size: 20.0, color: HexColor('#FF0000')),
                                new Positioned(
                                    top: 3.0,
                                    right: 6.0,
                                    child: new Center(
                                      child: new Text(
                                        shoppingCart.length.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class _MainBody extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  final ProductItem selectedProduct;

  const _MainBody(
      {this.animationController, this.dispatch, this.selectedProduct});
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
        child: GestureDetector(
          // Using the DragEndDetails allows us to only fire once per swipe.
          onVerticalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity < 0) {
              // Page up
            } else if (dragEndDetails.primaryVelocity > 0) {
              // Page down
              dispatch(ProductPageActionCreator.onBackToProduct());
            }
          },
          child: Container(
            color: HexColor('#50DDE1'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      selectedProduct.mediaUrls[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: selectedProduct.mediaUrls.length,
                  itemWidth: Adapt.screenW() * 0.6,
                  itemHeight: Adapt.screenW() * 0.6,
                  layout: SwiperLayout.STACK,
                  pagination: new SwiperPagination(
                      margin: new EdgeInsets.only(top: 260),
                      builder: new DotSwiperPaginationBuilder(
                          color: Colors.grey,
                          activeColor: HexColor('#3D9FB0'))),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  selectedProduct.name,
                  style: TextStyle(color: Colors.white, fontSize: 35),
                )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$${selectedProduct.price}',
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      selectedProduct.showOldPrice
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                '\$${selectedProduct.oldPrice}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.lineThrough,
                                    shadows: <Shadow>[
                                      Shadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 0,
                                          color: Colors.black),
                                      Shadow(
                                          offset: Offset(-1, -1),
                                          blurRadius: 0,
                                          color: Colors.black),
                                      Shadow(
                                          offset: Offset(1, -1),
                                          blurRadius: 0,
                                          color: Colors.black),
                                      Shadow(
                                          offset: Offset(-1, 1),
                                          blurRadius: 0,
                                          color: Colors.black),
                                    ]),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  'Quantity',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
                SizedBox(
                  height: 10,
                ),
                TouchSpin(
                    value: 10,
                    onChanged: (val) {
                      print(val);
                    },
                    min: 1,
                    max: 100,
                    step: 1,
                    iconSize: 20.0,
                    subtractIcon: Icon(Icons.remove),
                    addIcon: Icon(Icons.add),
                    iconPadding: EdgeInsets.all(0),
                    textStyle: TextStyle(fontSize: 18),
                    iconActiveColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    displayFormat: new NumberFormat("###")),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.white)),
                  color: Colors.transparent,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 12.0, left: 50, right: 50),
                  onPressed: () {},
                  child: Text(
                    '\$${selectedProduct.price} - Add to Cart'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 46,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/usamade.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Text(
                            'U.S.A made',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 46,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/shippingfast.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Text(
                            'Shipping Fast',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 46,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/guranteed.png"),
                                fit: BoxFit.contain),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Text(
                            'Quality\nGuranteed',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
                Center(
                    child: Text(
                  'Swipe down to go to the product page',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
