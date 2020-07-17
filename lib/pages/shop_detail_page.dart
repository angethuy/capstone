import 'package:flutter/material.dart';
import 'package:pagotometer/models/src/shop.dart';

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
      appBar: AppBar(
          // title: Text(widget.shop.fields.name),
          ),
      body: Center(child: Text(widget.shop.fields.displayPhone)),
      bottomNavigationBar: Center(
        child: Stack(children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.mood),
                  onPressed: showMenu,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Color(0xff232f34),
            ),
            child: Column(),
          );
        });
  }
}
