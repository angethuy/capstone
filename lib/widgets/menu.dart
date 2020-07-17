import 'package:flutter/material.dart';
import 'package:pagotometer/style/styles.dart';

class Menu extends StatelessWidget {
  Menu({this.flavors});
  final List<String> flavors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: flavors.length,
      itemBuilder: (BuildContext context, int index) {
        print('item: ${flavors[index]}');
        return Container(
          height: 50,
          child: Text(flavors[index]),
        );
      },
      // separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
