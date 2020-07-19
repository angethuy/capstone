import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:pagotometer/models/src/shop.dart';
import 'package:pagotometer/pages/shop_detail_page.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

Future<List<Shop>> fetchShops(http.Client client) async {
  final response = await client.get(
      'https://bpt8o079g2.execute-api.us-east-2.amazonaws.com/staging/getShops');

  // Use the compute function to run parseShops in a separate isolate.
  return compute(shopFromJson, response.body);
}

List<Shop> shopFromJson(String str) =>
    List<Shop>.from(json.decode(str).map((x) => Shop.fromJson(x)));

class ShopsListPage extends StatelessWidget {
  ShopsListPage({Key key}) : super(key: key);
  // final Position position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('position: ${position?.latitude}'),
          ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<List<Shop>>(
        future: fetchShops(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ShopsList(shops: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ShopsList extends StatelessWidget {
  final List<Shop> shops;

  ShopsList({Key key, this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shops.length,
      itemBuilder: (context, index) {
        debugPrint(
            '${shops[index].fields.coordinatesLatitude}, ${shops[index].fields.coordinatesLongitude} ');
        return ListTile(
            title: Text('${index + 1}: ${shops[index].fields.name}'),
            subtitle: Text('${shops[index].fields.flavors[0]}'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ShopDetailPage(shops[index])));
            });
      },
    );
  }
}
