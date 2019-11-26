class Location {
  var country, nearestTown = '';
  double lat;
  double long;

  Location() {}

  Location.withDemoData() {
    country = 'Australia';
    nearestTown = 'Melbourne';
    lat = -37.8136;
    long = 144.9631;
  }
}
