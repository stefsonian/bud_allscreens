import 'package:allscreens/src/front/front_screen.dart';
import 'package:allscreens/src/start/start_screen.dart';
import 'package:allscreens/src/trip/edit_participants_screen.dart';
import 'package:allscreens/src/trip/edit_trip_screen.dart';
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
              case 'edit trip':
                return EditTripScreen();
                break;
              case 'edit participants':
                return EditParticipantsScreen();
                break;
            }
          },
        );
      },
    );
  }
}
