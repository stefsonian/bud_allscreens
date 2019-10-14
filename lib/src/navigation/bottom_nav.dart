import 'package:allscreens/src/day/day_screen.dart';
import 'package:allscreens/src/expenses/expenses_screen.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/navigation/start_nav.dart';
import 'package:allscreens/src/record/record_screen.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/start/start_screen.dart';
import 'package:allscreens/src/stats/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'destination.dart';

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
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: appState.activeTabIndex == 2
          ? null
          : FloatingActionButton(
              backgroundColor:
                  appState.activeTabIndex == 2 ? col_aqua : col_orange,
              child: Icon(Icons.add),
              onPressed: () => appState.activeTabIndex = 2,
            ),
      body: IndexedStack(
        index: appState.activeTabIndex,
        // children: allDestinations.map<Widget>((Destination destination) {
        //   return DestinationView(destination: destination);
        // }).toList(),
        children: [
          StartNav(),
          ExpensesScreen(),
          RecordScreen(),
          DayScreen(),
          StatsScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // notchMargin: 20,
        color: col_aqua,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.only(left: 28),
                color: appState.activeTabIndex == 0
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.home),
                iconSize: 30,
                onPressed: () => appState.activeTabIndex = 0,
              ),
              IconButton(
                padding: EdgeInsets.only(right: 28.0),
                color: appState.activeTabIndex == 1
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.list),
                iconSize: 30,
                onPressed: () => appState.activeTabIndex = 1,
              ),
              IconButton(
                padding: EdgeInsets.only(left: 28.0),
                color: appState.activeTabIndex == 3
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.today),
                iconSize: 30,
                onPressed: () => appState.activeTabIndex = 3,
              ),
              IconButton(
                padding: EdgeInsets.only(right: 28.0),
                color: appState.activeTabIndex == 4
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.show_chart),
                iconSize: 30,
                onPressed: () => appState.activeTabIndex = 4,
              ),
            ],
          ),
        ),

        // currentIndex: appState.activeTabIndex,
        // onTap: (int index) => appState.activeTabIndex = index,
        // items: allDestinations.map((Destination destination) {
        //   return BottomNavigationBarItem(
        //       icon: Icon(destination.icon),
        //       // backgroundColor: Colors.black26,
        //       backgroundColor: col_aqua,
        //       title: Text(destination.title));
        // }).toList(),
      ),
    );
  }
}

// old:
//  Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         top: false,
//         child: IndexedStack(
//           index: appState.activeTabIndex,
//           // children: allDestinations.map<Widget>((Destination destination) {
//           //   return DestinationView(destination: destination);
//           // }).toList(),
//           children: [StartNav(), RecordScreen(), Start(), Start()],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         currentIndex: appState.activeTabIndex,
//         onTap: (int index) => appState.activeTabIndex = index,
//         items: allDestinations.map((Destination destination) {
//           return BottomNavigationBarItem(
//               icon: Icon(destination.icon),
//               // backgroundColor: Colors.black26,
//               backgroundColor: col_aqua,
//               title: Text(destination.title));
//         }).toList(),
//       ),
//     );
//   }
