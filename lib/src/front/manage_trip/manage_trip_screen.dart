import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/back_button_show_quick_add.dart';
import 'package:allscreens/src/front/manage_trip/manage_trip_form.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButtonShowQuickAdd(),
        backgroundColor: appState.cols.background2,
        title: Text('Edit current trip'),
        automaticallyImplyLeading: true,
      ),
      body: Background(
        child: Container(
          padding: EdgeInsets.all(12),
          child: ManageTripForm(),
        ),
      ),
    );
  }
}
