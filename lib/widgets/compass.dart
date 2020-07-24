import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pagotometer/bloc/location_bloc.dart';
import 'package:pagotometer/style/pago_icons.dart';
import 'package:pagotometer/style/styles.dart';
import 'package:pagotometer/utils/humanize.dart';

import 'package:pagotometer/widgets/circle_painter.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with TickerProviderStateMixin {
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num _heading;
    num _bearing;
    num _distance;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: 320,
          height: 320,
          child: CustomPaint(
            painter: CirclePainter(),
          ),
        ),
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is DistanceChanged) {
              _bearing = state.bearing;
              _distance = state.distance;
              _heading = state.heading ?? 45;
              // rotationController.reset();
              rotationController.animateTo(
                  1.0 - (((_heading + _bearing) % 360) / 360),
                  curve: Curves.easeInOutSine);
            }
          },
          child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    // "wow",
                    '${Humanize.distanceAway(_distance)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                // Text('$_distance away (bearing $_bearing, heading $_heading'),
                //  tanceAway(state.distance)}, bearing: ${state.bearing.toStringAsFixed(2)}, heading: ${state.heading?.toStringAsFixed(2)}')
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(rotationController),
                  child: Center(
                    child: Image.asset('assets/images/arrow.png'),
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }
  //   return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
  //     if (state is DistanceChanged) {
  //       return Stack(
  //         children: <Widget>[
  //           Container(
  //             width: 320,
  //             height: 320,
  //             child: CustomPaint(
  //               painter: CirclePainter(),
  //               child: Center(
  //                 child: Text(
  //                   '${Humanize.distanceAway(state?.distance)}',
  //                   style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           RotationTransition(
  //             turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
  //             child: Image.asset('assets/images/arrow.png'),
  //           ),
  //           RaisedButton(
  //             child: Text("go"),
  //             onPressed: () => rotationController.forward(),
  //           ),
  //         ],
  //       );
  //     } else {
  //       return Text("whoops");
  //     }
  //   });
  // }
}

// }

//WORKING

// if (state is CompassHeading) {
//         print('HEADING ${state?.heading}');
//       }
//       if (state is LocationInitial) {
//         // BlocProvider.of(context).setShop(latitude: widget.latitude);
//         print('fetching location');
//         return Center(child: Text('Fetching Location'));
//       } else if (state is DistanceChanged) {
//         print('distance changed');
//         // print('location loaded succcess!!!');
//         return Center(
//           child: Text(
//               '${Humanize.distanceAway(state.distance)}, bearing: ${state.bearing.toStringAsFixed(2)}, heading: ${state.heading?.toStringAsFixed(2)}'
//               // 'Location: (${state.position.latitude}, ${state.position.longitude})',
//               ),
//         );
//       } else {
//         print('nothing happening......');
//         return Center(child: CircularProgressIndicator());
//       }

// OLD
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
