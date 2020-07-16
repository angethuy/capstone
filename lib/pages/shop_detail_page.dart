import 'package:flutter/material.dart';
import 'package:pagotometer/models/src/shop.dart';

class ShopDetailPage extends StatelessWidget {
  final Shop shop;

  ShopDetailPage(this.shop);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shop.fields.name),
      ),
      body: Center(child: Text(shop.fields.displayPhone)),
    );
  }
}
