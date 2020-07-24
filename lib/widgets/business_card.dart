import 'package:flutter/material.dart';
import 'package:pagotometer/models/src/shop.dart';

class BusinessCard extends StatelessWidget {
  BusinessCard({this.shop});
  final Shop shop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: <Widget>[
          Text('${shop.fields.locationDisplayAddress001}'),
          Text('${shop.fields.locationDisplayAddress002}')
        ],
      ),
    );
  }
}
