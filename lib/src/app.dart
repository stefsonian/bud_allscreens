import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allscreens/src/record/add_record.dart';
import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/start/start.dart';
import 'package:allscreens/src/services/app_state.dart';

import 'navigation/stack_index_home.dart';

class App extends StatelessWidget {
  final appState = AppState();
  var appStateStream = Stream.fromIterable([AppState()]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: appState,
        ),
        ChangeNotifierProvider<RecordState>.value(
          value: RecordState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Container(
            // color: Colors.white70,
            child: Background(child: HomePage()),
          ),
        ),
      ),
    );
  }
}
