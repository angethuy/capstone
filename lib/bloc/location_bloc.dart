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

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoadInProgress extends LocationState {}

class LocationLoadSuccess extends LocationState {
  final Position position;

  LocationLoadSuccess({@required this.position});
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Geolocator _geolocator;
  StreamSubscription _locationSubscription;

  LocationBloc({@required Geolocator geolocator})
      : assert(geolocator != null),
        _geolocator = geolocator, super(null);

  LocationState get initialState => LocationInitial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is LocationStarted) {
      yield LocationLoadInProgress();
      _locationSubscription?.cancel();
      _locationSubscription = _geolocator.getPositionStream().listen(
            (Position position) => add(
              LocationChanged(position: position),
            ),
          );
    } else if (event is LocationChanged) {
      yield LocationLoadSuccess(position: event.position);
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
