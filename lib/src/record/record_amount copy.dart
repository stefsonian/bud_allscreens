import 'package:allscreens/src/components/splitter.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordAmount extends StatefulWidget {
  const RecordAmount({this.showNumpad});
  final bool showNumpad;

  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AmountDisplay(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
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
      padding: EdgeInsets.only(right: 20),
      child: Row(
        children: <Widget>[
          Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 2, 0),
                  child: Text(
                    'AUD  \$',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  '77.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
      padding: EdgeInsets.only(right: 20),
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: selectButton('Currency', Icons.monetization_on)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    number('1'),
                    number('2'),
                    number('3'),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 2, child: selectButton('Credit', Icons.credit_card)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[number('4'), number('5'), number('6')],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 2, child: selectButton('Split', Icons.call_split)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[number('7'), number('8'), number('9')],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 2, child: selectButton('Repeat', Icons.repeat)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        number('·'),
                        number('B'),
                      ],
                    ),
                    number('0'),
                    numIcon(Icons.arrow_back),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget number(String n) {
    Color color = n == 'B' ? Colors.transparent : Colors.white;
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          n,
          style: TextStyle(color: color, fontSize: 34),
        ),
      ),
    );
  }

  Widget numIcon(IconData icon) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          icon,
          color: Colors.white,
          size: 34,
        ),
      ),
    );
  }

  Widget selectButton(String label, IconData icon) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(width: 4),
          Text(label,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.visible),
        ],
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

// Widget number_alt(String n) {
//     return Container(
//       height: 65,
//       width: 65,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(360),
//         border: Border.all(width: 1, color: Colors.white),
//       ),
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           n,
//           style: TextStyle(color: Colors.white, fontSize: 34),
//         ),
//       ),
//     );
//   }
