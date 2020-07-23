import 'dart:math';

class GeoUtils {
  static double degToRad(double deg) {
    return (deg * pi / 180.0);
  }

  static double radToDeg(double rad) {
    return (rad * 180.0 / pi);
  }

  // return bearing between a starting point and end point
  // code modified from https://github.com/a14n/dart-geo/blob/master/lib/geo.dart
  static num getBearing(
      double startLat, double startLong, double endLat, double endLong) {
    // assert(startLat != null);
    // assert(startLong != null);
    // assert(startLat != null);
    // assert(startLong != null);
    final dLng = degToRad(endLong) - degToRad(startLong);
    final y = sin(dLng) * cos(degToRad(endLat));
    final x = cos(degToRad(startLat)) * sin(degToRad(endLat)) -
        sin(degToRad(startLat)) * cos(degToRad(endLat)) * cos(dLng);
    return radToDeg(atan2(y, x));
  }
}
