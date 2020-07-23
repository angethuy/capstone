import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pagotometer/utils/geo_utils.dart';
import 'package:flutter_compass/flutter_compass.dart';

@immutable
abstract class LocationEvent {}

class LocationStarted extends LocationEvent {}

class LocationChanged extends LocationEvent {
  final Position position;

  LocationChanged({@required this.position});
}

class ShopChanged extends LocationEvent {
  final double shopLat;
  final double shopLong;
  ShopChanged({@required this.shopLat, @required this.shopLong});
}

class CompassStarted extends LocationEvent {}

class CompassChanged extends LocationEvent {
  final double heading;
  CompassChanged({@required this.heading});
}

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final Position position;

  LocationLoadSuccess({@required this.position});
}

class DistanceChanged extends LocationState {
  final double distance;
  final num bearing;
  final double heading;

  DistanceChanged({this.distance, this.bearing, this.heading});
}

class CompassHeading extends LocationState {
  final double heading;
  CompassHeading({this.heading});
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator _geolocator;
  StreamSubscription _locationSubscription;
  StreamSubscription _compassSubscription;
  double _latitude;
  double _longitude;
  double _heading;

  LocationBloc({@required Geolocator geolocator})
      : assert(geolocator != null),
        _geolocator = geolocator,
        super(null);

  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    // await _simpleCompass.listen().then((data) {
    //   return HeadingChanged(heading: data);
    // });
    // if (event is HeadingChanged) {
    //   yield CurrentHeading(event.heading);
    // }
    if (event is CompassStarted) {
      _compassSubscription?.cancel();
      _compassSubscription = FlutterCompass.events
          .listen((double heading) => add(CompassChanged(heading: heading)));
    } else if (event is CompassChanged) {
      _heading = event.heading;
      // yield CompassHeading(heading: event.heading);
    } else if (event is ShopChanged) {
      print('SHOP CHANGED!');
      _latitude = event.shopLat;
      _longitude = event.shopLong;
    } else if (event is LocationStarted) {
      yield LocationLoadInProgress();
      _locationSubscription?.cancel();
      _locationSubscription = _geolocator.getPositionStream().listen(
            (Position position) => add(
              LocationChanged(position: position),
            ),
          );
    } else if (event is LocationChanged) {
      yield LocationLoadSuccess(position: event.position);
      // _headingSubscription?.cancel();
      // await _simpleCompass.listen().then((value) => add(
      //   HeadingChanged(heading: value),
      // ));

      // _simple
      // _headingSubscription = _flutterCompass.streamCompass.;

      if (_latitude != null && _longitude != null) {
        print('***distance changed detected!!');
        double currentDistance = await _calculateDistance(event);
        // double current_distance = _geolocator.distanceBetween(_latitude,
        //     _longitude, event.position.latitude, event.position.longitude);
        num currentBearing = _calculateBearing(event);
        yield DistanceChanged(
            distance: currentDistance,
            bearing: currentBearing,
            heading: _heading);
        // print('curr distance: ${currentDistance}');
      } //shop page
    }
  }

  // void setShop({double latitude, double longitude}) {
  //   _latitude = latitude;
  //   _longitude = longitude;
  // }

  Future<double> _calculateDistance(event) async {
    final double distance = await Geolocator().distanceBetween(_latitude,
        _longitude, event.position.latitude, event.position.longitude);
    return distance;
  }

  num _calculateBearing(event) {
    return GeoUtils.getBearing(_latitude, _longitude, event.position.latitude,
        event.position.longitude);
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    _compassSubscription?.cancel();
    return super.close();
  }
}
