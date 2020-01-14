import 'dart:convert';
import 'package:allscreens/src/models/Trip.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:allscreens/src/components/currency_selector.dart';
import 'package:allscreens/src/models/Location.dart';
import 'package:allscreens/src/models/Category.dart';
import 'package:allscreens/src/models/User.dart';
import 'package:flutter/material.dart';

// Contains all data from external sources and files
// *except* record data (expenses), which has its own service.
// This class only receives data from db, files and categories.
// No user input is or appstate-related info is stored here.
class SessionData with ChangeNotifier {
  Map<String, MainCategory> maincats;
  Map<String, SubCategory> subcats;
  List<Currency> currencies;
  User user;
  List<User> onDeviceUsers = [];
  List<Trip> trips = [];
  Location location;

  SessionData() {
    _initialiseMainCats();
    _initialiseSubCats();
    _initialiseLocation();
    _initialiseCurrencies();
  }

  SessionData.withCatsOnly() {
    _initialiseMainCats();
    _initialiseSubCats();
  }

  void _initialiseCurrencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    currencies = [];
    String data = await rootBundle.loadString('assets/currencies.json');

    Map currencyMap = json.decode(data);
    currencyMap.forEach((k, v) => currencies.add(Currency.fromMap({k: v})));
    currencies.sort((Currency a, Currency b) => a.id.compareTo(b.id));
  }

  Future<void> initialiseUser() async {
    await Future.delayed(Duration(milliseconds: 100), () {
      user = User.withDemoData('demouser A', 'Plato');
      onDeviceUsers.add(User.withDemoData('onDeviceUser1', 'Aristotle'));
      onDeviceUsers.add(User.withDemoData('onDeviceUser2', 'Anaximander'));
      _updateTrips();
    });
    notifyListeners();
  }

  void _initialiseLocation() {
    location = Location.withDemoData();
  }

  void _updateTrips() {
    user.trips.forEach((id) {
      var name = '$id name';
      List<User> allUsers = List.from(onDeviceUsers);
      allUsers.add(user);
      var t = Trip.withDemoData(id, name, allUsers);
      trips.add(t);
    });
  }

  Trip get trip => trips.firstWhere((t) => t.id == user.currentTrip);

  void _initialiseMainCats() {
    maincats = {};

    maincats['eat'] = MainCategory(
      id: 'eat',
      name: 'Eat',
      icon: Icons.restaurant,
    );
    maincats['sleep'] = MainCategory(
      id: 'sleep',
      name: 'Sleep',
      icon: Icons.local_hotel,
    );
    maincats['travel'] = MainCategory(
      id: 'travel',
      name: 'Travel',
      icon: Icons.directions_walk,
    );
    maincats['explore'] = MainCategory(
      id: 'explore',
      name: 'Explore',
      icon: Icons.camera_alt,
    );
    maincats['other'] = MainCategory(
      id: 'other',
      name: 'Other',
      icon: Icons.scatter_plot,
    );
  }

  void _initialiseSubCats() {
    subcats = {};

    subcats['breakfast'] = SubCategory(
      groupId: 'eat',
      id: 'breakfast',
      name: 'Breakfast',
      icon: Icons.restaurant,
    );
    subcats['lunch'] = SubCategory(
      groupId: 'eat',
      id: 'lunch',
      name: 'Lunch',
      icon: Icons.fastfood,
    );
    subcats['dinner'] = SubCategory(
      groupId: 'eat',
      id: 'dinner',
      name: 'Dinner',
      icon: Icons.local_dining,
    );
    subcats['snack'] = SubCategory(
      groupId: 'eat',
      id: 'snack',
      name: 'Snack',
      icon: Icons.local_pizza,
    );
    subcats['drink'] = SubCategory(
      groupId: 'eat',
      id: 'drink',
      name: 'Drink',
      icon: Icons.local_bar,
    );
    subcats['cafe'] = SubCategory(
      groupId: 'eat',
      id: 'cafe',
      name: 'Cafe',
      icon: Icons.local_cafe,
    );
    subcats['hydration'] = SubCategory(
      groupId: 'eat',
      id: 'hydration',
      name: 'Hydration',
      icon: Icons.local_drink,
    );
    subcats['eat_other'] = SubCategory(
      groupId: 'eat',
      id: 'eat_other',
      name: 'Other (Eat)',
      icon: Icons.restaurant,
    );
    subcats['train'] = SubCategory(
      groupId: 'travel',
      id: 'train',
      name: 'Train',
      icon: Icons.train,
    );
    subcats['tram'] = SubCategory(
      groupId: 'travel',
      id: 'tram',
      name: 'Tram',
      icon: Icons.tram,
    );
    subcats['metro'] = SubCategory(
      groupId: 'travel',
      id: 'metro',
      name: 'Metro',
      icon: Icons.directions_subway,
    );
    subcats['bus'] = SubCategory(
      groupId: 'travel',
      id: 'bus',
      name: 'Bus',
      icon: Icons.directions_bus,
    );
    subcats['flight'] = SubCategory(
      groupId: 'travel',
      id: 'flight',
      name: 'Flight',
      icon: Icons.flight,
    );
    subcats['ferry'] = SubCategory(
      groupId: 'travel',
      id: 'ferry',
      name: 'Ferry',
      icon: Icons.directions_boat,
    );
    subcats['car'] = SubCategory(
      groupId: 'travel',
      id: 'car',
      name: 'Car',
      icon: Icons.directions_car,
    );
    subcats['motorcycle'] = SubCategory(
      groupId: 'travel',
      id: 'motorcycle',
      name: 'Motorcycle',
      icon: Icons.motorcycle,
    );
    subcats['bike'] = SubCategory(
      groupId: 'travel',
      id: 'bike',
      name: 'Bike',
      icon: Icons.directions_bike,
    );
    subcats['travel_other'] = SubCategory(
      groupId: 'travel',
      id: 'travel_other',
      name: 'Other (Travel)',
      icon: Icons.directions_walk,
    );
    subcats['hotel'] = SubCategory(
      groupId: 'sleep',
      id: 'hotel',
      name: 'Hotel',
      icon: Icons.hotel,
    );
    subcats['hostel'] = SubCategory(
      groupId: 'sleep',
      id: 'hostel',
      name: 'Hostel',
      icon: Icons.location_city,
    );
    subcats['camping'] = SubCategory(
      groupId: 'sleep',
      id: 'camping',
      name: 'Camping',
      icon: Icons.event_seat,
    );
    subcats['airbnb'] = SubCategory(
      groupId: 'sleep',
      id: 'airbnb',
      name: 'Airbnb',
      icon: Icons.category,
    );
    subcats['sleep_other'] = SubCategory(
      groupId: 'sleep',
      id: 'sleep_other',
      name: 'Other (Sleep)',
      icon: Icons.local_hotel,
    );
    subcats['tour'] = SubCategory(
      groupId: 'explore',
      id: 'tour',
      name: 'Tour',
      icon: Icons.share,
    );
    subcats['sight'] = SubCategory(
      groupId: 'explore',
      id: 'sight',
      name: 'Sight',
      icon: Icons.camera_alt,
    );
    subcats['activity'] = SubCategory(
      groupId: 'explore',
      id: 'activity',
      name: 'Activity',
      icon: Icons.local_activity,
    );
    subcats['shopping'] = SubCategory(
      groupId: 'explore',
      id: 'shopping',
      name: 'Shopping',
      icon: Icons.add_shopping_cart,
    );
    subcats['market'] = SubCategory(
      groupId: 'explore',
      id: 'market',
      name: 'Market',
      icon: Icons.shopping_basket,
    );
    subcats['explore_other'] = SubCategory(
      groupId: 'explore',
      id: 'explore_other',
      name: 'Other (Explore)',
      icon: Icons.camera_alt,
    );
    subcats['groceries'] = SubCategory(
      groupId: 'other',
      id: 'groceries',
      name: 'Groceries',
      icon: Icons.shopping_cart,
    );
    subcats['medical'] = SubCategory(
      groupId: 'other',
      id: 'medical',
      name: 'Medical',
      icon: Icons.local_hospital,
    );
    subcats['laundry'] = SubCategory(
      groupId: 'other',
      id: 'laundry',
      name: 'Laundry',
      icon: Icons.local_laundry_service,
    );
    subcats['other_other'] = SubCategory(
      groupId: 'other',
      id: 'other_other',
      name: 'Other',
      icon: Icons.scatter_plot,
    );
  }
}

// SubCategory(groupId: 'eat', id: 'breakfast', name: 'Breakfast', icon: Icons.cake);
// SubCategory(groupId: 'eat', id: 'lunch', name: 'Lunch', icon: Icons.fastfood);
// SubCategory(groupId: 'eat', id: 'dinner', name: 'Dinner', icon: Icons.local_dining);
// SubCategory(groupId: 'eat', id: 'snack', name: 'Snack', icon: Icons.local_pizza);
// SubCategory(groupId: 'eat', id: 'drink', name: 'Drink', icon: Icons.local_bar);
// SubCategory(groupId: 'eat', id: 'cafe', name: 'Cafe', icon: Icons.local_cafe);
// SubCategory(groupId: 'eat', id: 'hydration', name: 'Hydration', icon: Icons.local_drink);
// SubCategory(groupId: 'eat', id:'eat_other', name: 'Other (Eat)', icon: Icons.restaurant);

// SubCategory(groupId: 'travel', id:'train', name: 'Train', icon: Icons.train);
// SubCategory(groupId: 'travel', id:'tram', name: 'Tram', icon: Icons.tram);
// SubCategory(groupId: 'travel', id:'metro', name: 'Metro', icon: Icons.directions_subway);
// SubCategory(groupId: 'travel', id:'bus', name: 'Bus', icon: Icons.directions_bus);
// SubCategory(groupId: 'travel', id:'flight', name: 'Flight', icon: Icons.flight);
// SubCategory(groupId: 'travel', id:'ferry', name: 'Ferry', icon: Icons.directions_boat);
// SubCategory(groupId: 'travel', id:'car', name: 'Car', icon: Icons.directions_car);
// SubCategory(groupId: 'travel', id:'motorcycle', name: 'Motorcycle', icon: Icons.motorcycle);
// SubCategory(groupId: 'travel', id:'bike', name: 'Bike', icon: Icons.directions_bike);
// SubCategory(groupId: 'travel', id:'travel_other', name: 'Other (Travel)', icon: Icons.directions_walk);

// SubCategory(groupId: 'sleep', id:'hotel', name: 'Hotel', icon: Icons.hotel);
// SubCategory(groupId: 'sleep', id:'hostel', name: 'Hostel', icon: Icons.location_city);
// SubCategory(groupId: 'sleep', id:'camping', name: 'Camping', icon: Icons.event_seat);
// SubCategory(groupId: 'sleep', id:'airbnb', name: 'Airbnb', icon: Icons.category);
// SubCategory(groupId: 'sleep', id:'sleep_other', name:'Other (Sleep)', icon: Icons.local_hotel);

// SubCategory(groupId: 'explore', id:'tour', name: 'Tour', icon: Icons.share);
// SubCategory(groupId: 'explore', id:'sight', name: 'Sight', icon: Icons.camera_alt);
// SubCategory(groupId: 'explore', id:'activity', name: 'Activity', icon: Icons.local_activity);
// SubCategory(groupId: 'explore', id:'shopping', name: 'Shopping', icon: Icons.add_shopping_cart);
// SubCategory(groupId: 'explore', id:'market', name: 'Market', icon: Icons.shopping_basket);
// SubCategory(groupId: 'explore', id:'explore_other', name: 'Other (Explore)', icon: Icons.camera_alt);

// SubCategory(groupId: 'other', id:'groceries', name: 'Groceries', icon: Icons.shopping_cart);
// SubCategory(groupId: 'other', id:'medical', name: 'Medical', icon: Icons.local_hospital);
// SubCategory(groupId: 'other', id:'laundry', name: 'Laundry', icon: Icons.local_laundry_service);
// SubCategory(groupId: 'other', id:'other_other', name: 'Other', icon: Icons.scatter_plot);
