import 'package:flutter/material.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';

class CompassSheet extends StatefulWidget {
  CompassSheet({Key key}) : super(key: key);

  @override
  _CompassSheetState createState() => _CompassSheetState();
}

class _CompassSheetState extends State<CompassSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Pagotometer.compass, size: 32.0),
              color: AppColor.highlightBlue,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}
