import 'package:eatsleeptravel/src/front/manage_trip/manage_trip_screen.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class TripOptionsDialog extends StatelessWidget {
  // BuildContext frontContext = InheritedWidget()
  tapEditCurrent(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ManageTripScreen(),
      ),
    );

    // Navigator.of(context).pushNamed('edit trip');
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ManageTripScreen()));

    // Navigator.pushNamed(context, 'edit trip');
    // Navigator.popAndPushNamed(context, 'edit trip');
    // Navigator.pushNamed(context, 'edit trip');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _button('Edit current trip', Icon(Icons.edit),
              () => tapEditCurrent(context), col_main1),
          SizedBox(height: 20),
          _button('Change trip', Icon(Icons.compare_arrows), () {}, col_main1),
          SizedBox(height: 20),
          _button('New trip', Icon(Icons.add), () {}, col_main1),
          SizedBox(height: 20),
          _button('Manage travel companions', Icon(Icons.person_add), () {},
              col_main1),
          SizedBox(height: 60),
          _button('Cancel', Icon(Icons.cancel), () {}, col_main1)
        ],
      ),
    );
  }

  Widget _button(String label, Icon icon, Function onPressed, Color color) {
    return Container(
      // width: 100,
      height: 60,
      child: FittedBox(
        fit: BoxFit.contain,
        child: FloatingActionButton.extended(
          label: Text(label),
          icon: icon,
          onPressed: onPressed,
          backgroundColor: color,
        ),
      ),
    );
  }
}
