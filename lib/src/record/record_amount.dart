import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display_amount.dart';

class RecordAmount extends StatefulWidget {
  const RecordAmount({this.showNumpad});
  final bool showNumpad;

  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AmountDisplay(),
          SizedBox(height: 26),
          NumGrid(),
        ],
      ),
    );
  }
}

class AmountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 2, 0),
            child: Text(
              '\$',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            '77.00',
            style: TextStyle(
                color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class NumGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(width: 1, color: Colors.white),
          ),
      height: 220,
      width: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[number('1'), number('2'), number('3')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[number('4'), number('5'), number('6')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[number('7'), number('8'), number('9')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              number('.'),
              number('0'),
              numIcon(Icons.arrow_back),
            ],
          ),
        ],
      ),
    );
  }

  Widget number_alt(String n) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        border: Border.all(width: 1, color: Colors.white),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          n,
          style: TextStyle(color: Colors.white, fontSize: 34),
        ),
      ),
    );
  }

  final sz = 55.0;
  Widget number(String n) {
    return Container(
      height: sz,
      width: sz,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(360),
      //   border: Border.all(width: 1, color: Colors.white),
      // ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          n,
          style: TextStyle(
              color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget numIcon(IconData icon) {
    return Container(
      height: sz,
      width: sz,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(360),
      //   border: Border.all(width: 1, color: Colors.white),
      // ),
      child: Align(
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
          size: 34,
        ),
      ),
    );
  }
}

// class RoundButton extends StatelessWidget {
//   const RoundButton({Key key, this.icon}) : super(key: key);
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     RecordState recordState = Provider.of<RecordState>(context);
//     return SizedBox(
//       width: 80,
//       child: FittedBox(
//         child: FloatingActionButton(
//           child: SizedBox(
//             height: 50,
//             child: FittedBox(
//               child: Icon(Icons.arrow_right),
//             ),
//           ),
//           backgroundColor: Colors.white,
//           foregroundColor: col_aqua,
//           onPressed: () => recordState.isAmountRecorded = true,
//         ),
//       ),
//     );
//   }
// }
