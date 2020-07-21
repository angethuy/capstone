import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

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

  DistanceChanged({this.distance});
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator _geolocator;
  StreamSubscription _locationSubscription;
  double _latitude;
  double _longitude;

  LocationBloc({@required Geolocator geolocator})
      : assert(geolocator != null),
        _geolocator = geolocator,
        super(null);

  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is ShopChanged) {
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
      if (_latitude != null && _longitude != null) {
        print('***distance changed detected!!');
        double currentDistance = await _calculateDistance(event);
        // double current_distance = _geolocator.distanceBetween(_latitude,
        //     _longitude, event.position.latitude, event.position.longitude);
        yield DistanceChanged(distance: currentDistance);
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

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
