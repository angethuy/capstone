import 'package:flutter/material.dart';
import 'package:pagotometer/style/styles.dart';

class Menu extends StatelessWidget {
  Menu({this.flavors});
  final List<String> flavors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: flavors.length,
          itemBuilder: (BuildContext context, int index) {
            print('item: ${flavors[index]}');
            return Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(flavors[index]),
              ),
            );
          }),
      // separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
