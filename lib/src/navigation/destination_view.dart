import 'package:allscreens/src/record/add_record.dart';
import 'package:allscreens/src/record/record_categories.dart';
import 'package:flutter/material.dart';

import 'destination.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return AddRecord();
            case '/categories':
              return RecordCategories();
            //   return RootPage(destination: widget.destination);
            // case '/list':
            //   return ListPage(destination: widget.destination);
            // case '/text':
            //   return TextPage(destination: widget.destination);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
