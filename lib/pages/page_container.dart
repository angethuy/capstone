import 'package:flutter/material.dart';
import 'package:pagotometer/pages/shops_list_page.dart';

class PageContainer extends StatefulWidget {
  final String title;

  PageContainer({Key key, this.title}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  Widget build(BuildContext context) {
    return ShopsListPage();
  }

  // FutureBuilder<List<Shop>>(
  //       future: fetchShops(http.Client()),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) print(snapshot.error);

  //         return snapshot.hasData
  //             ? ShopsList(shops: snapshot.data)
  //             : Center(child: CircularProgressIndicator());
  //       },
  //     ),

}
