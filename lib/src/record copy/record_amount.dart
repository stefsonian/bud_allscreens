// import 'package:allscreens/src/components/Ikon_button.dart';
// import 'package:allscreens/src/components/gradient_box.dart';
// import 'package:allscreens/src/components/numpad.dart';
// import 'package:allscreens/src/helpers/colors.dart';
// import 'package:allscreens/src/services/record_state.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'display_amount.dart';

// class RecordAmount extends StatefulWidget {
//   const RecordAmount({this.showNumpad});
//   final bool showNumpad;

//   _RecordAmountState createState() => _RecordAmountState();
// }

// class _RecordAmountState extends State<RecordAmount> {
//   Widget build(BuildContext context) {
//     RecordState recordState = Provider.of<RecordState>(context);
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Numpad(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               RoundButton(icon: Icons.arrow_right),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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
