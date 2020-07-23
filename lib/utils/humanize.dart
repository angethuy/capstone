/// This class is used to turn enum values, date times, etc into human-readable Strings
class Humanize {
  // return humanized distance given the meters
  static String distanceAway(double meters) {
    if (meters > 400) {
      var metersAsMiles = (meters / 1609);
      return '${metersAsMiles.toStringAsFixed(2)} miles';
    } else {
      return '${meters.toStringAsFixed(2)} meters';
    }
  }
}
