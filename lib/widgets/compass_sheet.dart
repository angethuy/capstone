import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pagotometer/bloc/location_bloc.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';
// import '../widgets/location_stream_widget.dart';

class CompassSheet extends StatefulWidget {
  final double latitude;
  final double longitude;
  CompassSheet({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _CompassSheetState createState() => _CompassSheetState();
}

class _CompassSheetState extends State<CompassSheet> {
  @override
  Widget build(BuildContext context) {
    context
        .bloc<LocationBloc>()
        .add(ShopChanged(shopLat: widget.latitude, shopLong: widget.longitude));
    print('${widget.latitude}, LONG: ${widget.longitude}');
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
            // color: Colors.yellow,
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationInitial) {
                  // BlocProvider.of(context).setShop(latitude: widget.latitude);
                  print('fetching location');
                  return Center(child: Text('Fetching Location'));
                }
                if (state is DistanceChanged) {
                  print('distance changed');
                  // print('location loaded succcess!!!');
                  return Center(
                    child: Text('Distance: ${state.distance}'
                        // 'Location: (${state.position.latitude}, ${state.position.longitude})',
                        ),
                  );
                }
                print('nothing happening......');
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}
