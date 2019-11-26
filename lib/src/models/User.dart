class User {
  String id, email, name, homeCurrency, currentTrip = '';
  List<String> trips = [];
  bool isAnonymous = true;

  User() {}

  User.withDemoData(String id, String name) {
    id = id;
    name = name;
    email = '$id@email.com';
    homeCurrency = 'AUD';
    trips = ['demotrip1', 'demotrip2'];
    currentTrip = 'demotrip1';
  }
}
