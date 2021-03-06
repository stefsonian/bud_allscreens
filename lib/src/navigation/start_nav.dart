import 'package:eatsleeptravel/src/front/front_screen.dart';
import 'package:eatsleeptravel/src/front/manage_trip/manage_trip_screen.dart';
import 'package:eatsleeptravel/src/front/select_trip/select_trip_screen.dart';
import 'package:eatsleeptravel/src/front/trip_companions/trip_companions_screen.dart';

import 'package:flutter/material.dart';

class StartNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/':
                return FrontScreen();
                break;
              case 'new trip':
                return ManageTripScreen(isCreateMode: settings.arguments);
                break;
              case 'edit trip':
                return ManageTripScreen();
                break;
              case 'select trip':
                return SelectTripScreen();
                break;
              case 'edit participants':
                return TripCompanionsScreen();
                break;
            }
          },
        );
      },
    );
  }
}
