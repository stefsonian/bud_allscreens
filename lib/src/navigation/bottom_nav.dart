import 'package:allscreens/src/navigation/start_nav.dart';
import 'package:allscreens/src/record/record_screen.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/start/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'destination.dart';
import 'destination_view.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with TickerProviderStateMixin<BottomNav> {
  // int _currentIndex = 0; note: We use appState.activeTabIndex instead.
  AppState appState;

  didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: appState.activeTabIndex,
          // children: allDestinations.map<Widget>((Destination destination) {
          //   return DestinationView(destination: destination);
          // }).toList(),
          children: [StartNav(), RecordScreen(), Start(), Start()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: appState.activeTabIndex,
        onTap: (int index) => appState.activeTabIndex = index,
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              backgroundColor: Colors.black26,
              title: Text(destination.title));
        }).toList(),
      ),
    );
  }
}
