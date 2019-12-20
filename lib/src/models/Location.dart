class Location {
  var countryId, countryName, nearestTown = '';
  double lat;
  double long;

  Location() {}

  Location.withDemoData() {
    countryId = 'au';
    countryName = 'Australia';
    nearestTown = 'Melbourne';
    lat = -37.8136;
    long = 144.9631;
  }
}
