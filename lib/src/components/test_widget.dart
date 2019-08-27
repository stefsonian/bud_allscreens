import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key key, this.expanded, this.min, this.max})
      : super(key: key);
  final bool expanded;
  final int max;
  final int min;

  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var expandedStatus;
  var forwardNext = true;
  String controller = 'Start text';
  int begin;
  int end;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    expandedStatus = widget.expanded;
    begin = expandedStatus ? widget.max : widget.min;
    end = expandedStatus ? widget.min : widget.max;
  }

  updateController() {
    if (forwardNext) {
      setState(() {
        controller = 'Forward: I was ${expandedStatus.toString()}';
        forwardNext = false;
      });
    } else if (!forwardNext) {
      setState(() {
        controller = 'Reverse: I was ${expandedStatus.toString()}';
        forwardNext = true;
      });
    }
    expandedStatus = !expandedStatus;
  }

  Widget build(BuildContext context) {
    if (expandedStatus != widget.expanded) updateController();
    return Center(
      child: Container(
        child: Text(controller),
      ),
    );
  }
}
