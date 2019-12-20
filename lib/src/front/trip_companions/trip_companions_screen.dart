import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/back_button_show_quick_add.dart';
import 'package:allscreens/src/front/trip_companions/trip_companions_list.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class TripCompanionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: BackButtonShowQuickAdd(),
        backgroundColor: col_main1,
        title: Text('Trip companions'),
        automaticallyImplyLeading: true,
      ),
      body: Background(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          child: TripCompanionsList(),
        ),
      ),
    );
  }
}
