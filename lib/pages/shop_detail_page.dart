import 'package:flutter/material.dart';
import 'package:pagotometer/models/src/shop.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';
import 'package:pagotometer/widgets/menu.dart';
import 'package:pagotometer/widgets/business_card.dart';
import 'package:pagotometer/widgets/compass_sheet.dart';
import 'package:geolocator/geolocator.dart';

class ShopDetailPage extends StatefulWidget {
  final Shop shop;

  ShopDetailPage(this.shop);

  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  // Position _currentPosition;
  // double _distance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mutedPurple,
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(widget.shop.fields.name,
              style: TextStyle(
                fontSize: 30,
              ))),
      body: Container(
          child: Column(
        children: <Widget>[
          BusinessCard(shop: widget.shop),
          Divider(
            color: AppColor.lightPurple,
            height: 20,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Menu(flavors: widget.shop.fields.flavors),
        ],
      )),
      // body: Menu(flavors: widget.shop.fields.flavors),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppColor.midnightPurple,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(children: <Widget>[
            Spacer(),
            IconButton(
              onPressed: showMenu,
              icon: Icon(Pagotometer.compass),
              color: Colors.white,
            ),
            Spacer(),
          ]),
        ),
      ),
    );
  }

  showMenu() {
    // _getCurrentLocation();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: AppColor.midnightPurple,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: CompassSheet(
            latitude: double.parse(widget.shop.fields.coordinatesLatitude),
            longitude: double.parse(widget.shop.fields.coordinatesLongitude)),
      ),
    );
  }

  // _getCurrentLocation() {
  //   final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       print(
  //           'Location: ${_currentPosition?.latitude}, ${_currentPosition?.longitude} ');
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
}
// builder: (BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20.0),
//         topRight: Radius.circular(20.0),
//       ),
//       color: AppColor.midnightPurple,
//     ),
//     child: Column(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.green,
//           ),
//         ),
//         Expanded(
//           flex: 8,
//           child: Container(
//             color: Colors.yellow,
//           ),
//         ),
//       ],
//     ),
//   );
// });
