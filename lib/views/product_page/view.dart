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

import 'package:cached_network_image/cached_network_image.dart';

import 'package:dosparkles/utils/ensure_visible_when_focused.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ProductPageState state, Dispatch dispatch, ViewService viewService) {
  Adapt.initContext(viewService.context);
  print('state.optionalMaterialSelected: ${state.optionalMaterialSelected}');
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _MainBody(
          animationController: state.animationController,
          dispatch: dispatch,
          selectedProduct: state.selectedProduct,
          optionalMaterialSelected: state.optionalMaterialSelected,
          productQuantity: state.productQuantity,
        ),
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
  final  List<CartItem> shoppingCart;
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
  final bool optionalMaterialSelected;
  final int productQuantity;

  _MainBody(
      {this.animationController,
      this.dispatch,
      this.selectedProduct,
      this.optionalMaterialSelected,
      this.productQuantity});

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

    print('_MainBody optionalMaterialSelected: $optionalMaterialSelected');

    int _productQuantity = productQuantity == null ? 1 : productQuantity;

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
                    value: _productQuantity,
                    onChanged: (val) {
                      print('TouchSpin val: $val');
                      // productQuantity = val.toInt();
                      dispatch(ProductPageActionCreator.onSetProductCount(
                          val.toInt()));
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _ProductCustomization(
                              dispatch: dispatch,
                              selectedProduct: selectedProduct,
                              productQuantity: productQuantity,
                              optionalMaterialSelected:
                                  optionalMaterialSelected);
                        });
                  },
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

class _ProductCustomization extends StatelessWidget {
  final Dispatch dispatch;
  final ProductItem selectedProduct;
  final int productQuantity;
  final bool optionalMaterialSelected;
  bool _optionalMaterialSelected;

  _ProductCustomization(
      {this.dispatch,
      this.selectedProduct,
      this.productQuantity,
      this.optionalMaterialSelected});
  @override
  Widget build(BuildContext context) {
    print(
        '_ProductCustomization optionalMaterialSelected: $optionalMaterialSelected');
    _optionalMaterialSelected = optionalMaterialSelected;

    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            // height: height - 200,
            width: width - 40,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  width: 50,
                  height: 50,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: RawMaterialButton(
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        size: 26.0,
                      ),
                      padding: EdgeInsets.all(0.0),
                      shape: CircleBorder(),
                      onPressed: () {
                        print('onPressed');
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        selectedProduct.name,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Made in USA',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (selectedProduct.showOldPrice
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
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
                                              color: Colors.red),
                                          Shadow(
                                              offset: Offset(-1, -1),
                                              blurRadius: 0,
                                              color: Colors.red),
                                          Shadow(
                                              offset: Offset(1, -1),
                                              blurRadius: 0,
                                              color: Colors.red),
                                          Shadow(
                                              offset: Offset(-1, 1),
                                              blurRadius: 0,
                                              color: Colors.red),
                                        ]),
                                  ),
                                )
                              : Container()),
                          //
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              '\$${selectedProduct.price}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //
                    selectedProduct.engraveAvailable ||
                            selectedProduct.optionalFinishMaterialEnabled
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'Add a ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                                children: <TextSpan>[
                                  selectedProduct.engraveAvailable
                                      ? TextSpan(
                                          text:
                                              'personal message'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : TextSpan(),
                                  selectedProduct.engraveAvailable &&
                                          selectedProduct
                                              .optionalFinishMaterialEnabled
                                      ? TextSpan(
                                          text: ' and ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal))
                                      : TextSpan(),
                                  selectedProduct.optionalFinishMaterialEnabled
                                      ? TextSpan(
                                          text: 'gold finish'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : TextSpan(),
                                ]),
                          )
                        : Container(),
                    //
                    selectedProduct.engraveAvailable
                        ? Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                '1. Engrave  Personal Message',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '50% Off - One-time Offer ! ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '\n( ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                          text: selectedProduct
                                                  .showOldEngravePrice
                                              ? '\$${selectedProduct.engraveOldPrice} '
                                              : '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                      TextSpan(
                                        text: ' \$${selectedProduct.price} ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ')',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                              //
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  selectedProduct.engraveExampleUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: new CachedNetworkImage(
                                            imageUrl: selectedProduct
                                                .engraveExampleUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       hintText: 'Enter a search term'),
                                  // )
                                ],
                              ),
                            ],
                          )
                        : Container(),

                    //
                    selectedProduct.optionalFinishMaterialEnabled
                        ? Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                '2. ${selectedProduct.optionalFinishMaterial}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '50% Off - One-time Offer ! ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '\n( ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                          text: selectedProduct
                                                  .showOldEngravePrice
                                              ? '\$${selectedProduct.optionalFinishMaterialPrice} '
                                              : '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          )),
                                      // TextSpan(
                                      //   text: '\$${selectedProduct.price} ',
                                      //   style: TextStyle(
                                      //     color: Colors.red,
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // ),
                                      TextSpan(
                                        text: ')',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                              //
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  selectedProduct.engraveExampleUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: new CachedNetworkImage(
                                            imageUrl: selectedProduct
                                                .optionalMaterialExampleUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                                  Column(
                                    children: [
                                      // Text(
                                      //     '$_optionalMaterialSelected $productQuantity'),
                                      Text(
                                        'Add ${selectedProduct.optionalFinishMaterial}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 30.0,
                                        padding: EdgeInsets.only(
                                            left: 4, right: 4, top: 0),
                                        icon: InkWell(
                                          child: _optionalMaterialSelected ==
                                                  true
                                              ? Icon(Icons.check_circle_outline,
                                                  color: HexColor('#15CCF4'))
                                              : Icon(
                                                  Icons.check_circle_outline,
                                                  color: Colors.grey,
                                                ),
                                          onTap: () {
                                            print(
                                                'optionalMaterialSelected: $optionalMaterialSelected !optionalMaterialSelected ${!optionalMaterialSelected}');
                                            dispatch(ProductPageActionCreator
                                                .onSetOptionMaterialSelected(
                                                    !_optionalMaterialSelected));
                                            _optionalMaterialSelected =
                                                !_optionalMaterialSelected;
                                          },
                                        ),
                                        // onPressed: () {
                                        //   print(
                                        //       'onSetOptionMaterialSelected');
                                        //   dispatch(ProductPageActionCreator
                                        //       .onSetOptionMaterialSelected(
                                        //           !optionalMaterialSelected));
                                        // },
                                      ),
                                    ],
                                  )
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       hintText: 'Enter a search term'),
                                  // )
                                ],
                              ),
                            ],
                          )
                        : Container(),

                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.grey)),
                      color: Colors.transparent,
                      textColor: Colors.red,
                      padding: EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 50, right: 50),
                      onPressed: () async {
                        await dispatch(ProductPageActionCreator.onAddToCart(selectedProduct, productQuantity));
                        dispatch(ProductPageActionCreator.onGoToCart());
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return _ProductCustomization(
                        //           dispatch: dispatch,
                        //           selectedProduct: selectedProduct,
                        //           productQuantity: productQuantity);
                        //     });
                      },
                      child: Text(
                        'Customize and Proceed',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
