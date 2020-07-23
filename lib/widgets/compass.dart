import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pagotometer/bloc/location_bloc.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';
import 'package:pagotometer/utils/humanize.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state is CompassHeading) {
        print('HEADING ${state?.heading}');
      }
      if (state is LocationInitial) {
        // BlocProvider.of(context).setShop(latitude: widget.latitude);
        print('fetching location');
        return Center(child: Text('Fetching Location'));
      } else if (state is DistanceChanged) {
        print('distance changed');
        // print('location loaded succcess!!!');
        return Center(
          child: Text(
              '${Humanize.distanceAway(state.distance)}, bearing: ${state.bearing}, heading: ${state.heading}'
              // 'Location: (${state.position.latitude}, ${state.position.longitude})',
              ),
        );
      } else {
        print('nothing happening......');
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}

// }

// BlocBuilder<LocationBloc, LocationState>(
//               builder: (context, state) {
//                 if (state is LocationInitial) {
//                   // BlocProvider.of(context).setShop(latitude: widget.latitude);
//                   print('fetching location');
//                   return Center(child: Text('Fetching Location'));
//                 } else if (state is DistanceChanged) {
//                   print('distance changed');
//                   // print('location loaded succcess!!!');
//                   return Center(
//                     child: Text('Distance: ${state.distance}'
//                         // 'Location: (${state.position.latitude}, ${state.position.longitude})',
//                         ),
//                   );
//                 } else
//                   print('nothing happening......');
//                 return Center(child: CircularProgressIndicator());
//               },
//             ),
