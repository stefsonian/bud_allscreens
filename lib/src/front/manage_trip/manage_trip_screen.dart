import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/back_button_show_quick_add.dart';
import 'package:eatsleeptravel/src/front/manage_trip/manage_trip_form.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageTripScreen extends StatelessWidget {
  const ManageTripScreen({Key key, this.isCreateMode = false})
      : super(key: key);
  final bool isCreateMode;

  @override
  Widget build(BuildContext context) {
    var header = isCreateMode ? 'Add new trip' : 'Edit current trip';
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButtonShowQuickAdd(),
        backgroundColor: appState.cols.background2,
        title: Text(header),
        automaticallyImplyLeading: true,
      ),
      body: Background(
        child: Container(
          padding: EdgeInsets.all(12),
          child: ManageTripForm(isCreateMode: isCreateMode),
        ),
      ),
    );
  }
}
