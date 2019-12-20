class User {
  String id, email, name, homeCurrency, currentTrip = '';
  List<String> trips = [];
  bool isAnonymous = true;
  String currencyLastUsed; // id of the last currency they used
  String countryLastIn; // id of the country they were in at last expense
  String paymentMethodLastUsed;

  User() {}

  User.withDemoData(String id, String name) {
    id = id;
    name = name;
    email = '$id@email.com';
    homeCurrency = 'AUD';
    trips = ['demotrip1', 'demotrip2'];
    currentTrip = 'demotrip1';
    currencyLastUsed = 'AUD';
    countryLastIn = 'au';
    paymentMethodLastUsed = 'card';
  }
}
