import 'package:allscreens/src/components/tapered_divider_h.dart';
import 'package:allscreens/src/components/tapered_divider_v.dart';
import 'package:flutter/material.dart';

class DividerGrid extends StatelessWidget {
  const DividerGrid({Key key, this.horizontalDividers, this.verticalDividers})
      : super(key: key);

  final int horizontalDividers;
  final int verticalDividers;

  @override
  Widget build(BuildContext context) {
    List<Widget> hDivs = [Spacer()];
    List<Widget> vDivs = [Spacer()];
    for (var i = 0; i < horizontalDividers; i++) {
      hDivs.add(TaperedDividerH());
      hDivs.add(Spacer());
    }
    for (var i = 0; i < verticalDividers; i++) {
      vDivs.add(TaperedDividerV());
      vDivs.add(Spacer());
    }

    return Stack(
      children: <Widget>[
        Column(
          children: hDivs,
        ),
        Row(
          children: vDivs,
        ),
      ],
    );
  }
}
