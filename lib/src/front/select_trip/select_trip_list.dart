import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> trips = ['Buenos Aires', 'Copenhagen', 'Brisbane', 'Toledo'];

class SelectTripList extends StatefulWidget {
  @override
  _SelectTripListState createState() => _SelectTripListState();
}

class _SelectTripListState extends State<SelectTripList> {
  SessionData sessionData;
  AppState appState;
  Records records;
  FirestoreService firestore = FirestoreService();
  List<Trip> trips;
  int selectedIndex;

  @override
  void didChangeDependencies() {
    sessionData = Provider.of<SessionData>(context);
    appState = Provider.of<AppState>(context);
    records = Provider.of<Records>(context);
    if (trips == null) _initialiseTrips();
    super.didChangeDependencies();
  }

  _initialiseTrips() async {
    QuerySnapshot qs =
        await firestore.getUserTrips(userId: sessionData.user.id);
    List<Trip> fireTrips = qs.documents
        .map((doc) => Trip.fromFirestoreData(doc.documentID, doc.data))
        .toList();
    fireTrips.sort((a, b) => a.name.compareTo(b.name));
    var currentTripIndex =
        fireTrips.indexWhere((t) => t.id == records.currentTripId);
    setState(() => selectedIndex = currentTripIndex);
    setState(() => trips = fireTrips);
  }

  _onTripTap(int index) {
    setState(() => selectedIndex = index);
    String newId = trips[index].id;
    firestore.setUserCurrentTrip(
      userId: sessionData.user.id,
      tripId: newId,
    );
    records.currentTripId = newId;
  }

  @override
  Widget build(BuildContext context) {
    if (trips == null) return Center(child: CircularProgressIndicator());
    return Container(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: trips.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // height: 16,
            child: _tripTile(trips[index], index),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  Widget _tripTile(Trip trip, int index) {
    Color textCol = index == selectedIndex
        ? appState.cols.content
        : appState.cols.content.withOpacity(0.6);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    trip.name,
                    style: TextStyle(
                      color: textCol,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${trip.startDayMonth} ${trip.startDT.year} - ${trip.endDayMonth} ${trip.startDT.year}',
                    style: TextStyle(
                      color: textCol,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Total spend: spend amount', // TODO: put actual spend amount here,
                    style: TextStyle(
                      color: textCol,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 38,
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    child: index == selectedIndex
                        ? Icon(
                            Icons.check,
                            color: appState.cols.background2,
                          )
                        : Container(),
                    backgroundColor: textCol,
                    onPressed: () => _onTripTap(index),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => _onTripTap(index),
    );
  }
}
