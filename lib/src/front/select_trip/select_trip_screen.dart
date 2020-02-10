import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/back_button_show_quick_add.dart';
import 'package:eatsleeptravel/src/front/select_trip/select_trip_list.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButtonShowQuickAdd(),
        backgroundColor: appState.cols.background2,
        title: Text('Select trip'),
        automaticallyImplyLeading: true,
      ),
      body: Background(
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(12),
          child: SelectTripList(),
        ),
      ),
    );
  }
}
