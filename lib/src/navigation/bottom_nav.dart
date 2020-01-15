import 'package:eatsleeptravel/src/day/day_screen.dart';
import 'package:eatsleeptravel/src/expenses/expenses_screen.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/navigation/start_nav.dart';
import 'package:eatsleeptravel/src/record/record_screen.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/stats/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with TickerProviderStateMixin<BottomNav> {
  AppState appState;

  didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
  }

  _handleAppBarTap(int index) {
    appState.activeTabIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      extendBody: true,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: null,
      floatingActionButton: appState.showQuickAddButton
          ? FloatingActionButton(
              backgroundColor: appState.cols.action,
              child: Icon(Icons.add, color: appState.cols.actioncontent),
              heroTag: 'Add expense',
              onPressed: () => _handleAppBarTap(2),
            )
          : null,
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
        color: appState.cols.background2,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: appState.showToolBar ? 60 : 0,
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
                onPressed: () => _handleAppBarTap(0),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 28.0),
                color: appState.activeTabIndex == 1
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.list),
                iconSize: 30,
                onPressed: () => _handleAppBarTap(1),
              ),
              IconButton(
                padding: EdgeInsets.only(left: 28.0),
                color: appState.activeTabIndex == 3
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.today),
                iconSize: 30,
                onPressed: () => _handleAppBarTap(3),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 28.0),
                color: appState.activeTabIndex == 4
                    ? Colors.white
                    : Colors.white70,
                icon: Icon(Icons.show_chart),
                iconSize: 30,
                onPressed: () => _handleAppBarTap(4),
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
