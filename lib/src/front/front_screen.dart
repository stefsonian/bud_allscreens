import 'package:allscreens/src/front/front_averages.dart';
import 'package:allscreens/src/front/front_by_category.dart';
import 'package:allscreens/src/front/front_by_hashtag.dart';
import 'package:allscreens/src/front/front_by_person.dart';
import 'package:allscreens/src/front/front_recent.dart';
import 'package:allscreens/src/front/front_stats.dart';
import 'package:allscreens/src/front/trip_options_popup.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/models/Trip.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  SessionData session;

  @override
  void didChangeDependencies() {
    session = Provider.of<SessionData>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                tooltip: 'User settings',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings),
                tooltip: 'App settings',
                onPressed: () {},
              ),
            ],
            floating: true,
            snap: true,
            backgroundColor: col_aqua,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              background: _tripInfo(context),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontRecent(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontStats(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontAverages(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontByCategory(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontByHashtag(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FrontByPerson(),
                ),
                SizedBox(height: 100),
              ],
            ),

            // SliverChildBuilderDelegate(
            //   (BuildContext context, int index) {
            //     final Color color =
            //         index.isEven ? Colors.pink : Colors.yellowAccent;
            //     return Container(
            //       height: 100,
            //       color: color,
            //     );
            //   },
            //   childCount: 30,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _tripInfo(BuildContext context) {
    var tripText = session.trip.name;
    return Container(
      padding: EdgeInsets.only(left: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        tripText,
                        style: TextStyle(
                          fontSize: tripText.length < 19 ? 22 : 18,
                          letterSpacing: 1.1,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.edit),
                    //   color: Colors.white,
                    //   tooltip: 'Edit trip',
                    //   // padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                    //   // onPressed: () =>
                    //   //     Navigator.pushNamed(context, 'edit trip'),
                    //   onPressed: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) => SimpleDialog(
                    //         backgroundColor: Colors.transparent,
                    //         elevation: 0,

                    //         // shape: RoundedRectangleBorder(
                    //         //     borderRadius: BorderRadius.circular(14)),
                    //         children: <Widget>[
                    //           TripOptionsDialog(),
                    //         ],
                    //       ),
                    //     );

                    //   },
                    // ),
                    TripOptionsPopup(),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          ),
          // SizedBox(height: 2),
          Text(
            '${session.trip.startDayMonth} - ${session.trip.endDayMonth}  •  day ${session.trip.travelDay}',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Container(
  //       padding: EdgeInsets.fromLTRB(8, 14, 8, 10),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           FrontTrip(),
  //           SizedBox(height: 14),
  //           Expanded(child: FrontStats()),
  //           SizedBox(height: 14),
  //           FrontAverages(),
  //           // SizedBox(height: 50),
  //           // _addExpenseButton(),
  //           SizedBox(height: 30),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _addExpenseButton() {
  //   return SizedBox(
  //     width: 200,
  //     child: FloatingActionButton.extended(
  //       label: Text('Expense'),
  //       icon: Icon(Icons.add),
  //       backgroundColor: col_orange,
  //       onPressed: () {},
  //     ),
  //   );
  // }
}
