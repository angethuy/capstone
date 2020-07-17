import 'package:flutter/material.dart';
import 'package:pagotometer/models/src/shop.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';
import 'package:pagotometer/widgets/menu.dart';
import 'package:pagotometer/widgets/compass_sheet.dart';

class ShopDetailPage extends StatefulWidget {
  final Shop shop;

  ShopDetailPage(this.shop);

  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightPurple,
      appBar: AppBar(title: Text(widget.shop.fields.name)),
      body: Menu(flavors: widget.shop.fields.flavors),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xff344955),
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
        child: CompassSheet(),
      ),
    );
  }
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
