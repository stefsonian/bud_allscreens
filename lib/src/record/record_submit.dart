import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/record/record_stepper.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Container();

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: <Widget>[
    //         IkonButton(
    //           color: col_orange_dark,
    //           backColor: Colors.white,
    //           icon: Icons.delete,
    //           onTap: () => recordState.reset(),
    //         ),
    //         IkonButton(
    //           color: col_aqua,
    //           backColor: Colors.white,
    //           icon: Icons.check,
    //           size: 120.0,
    //           onTap: () => recordState.reset(),
    //         ),
    //       ],
    //     ),
    //     SizedBox(height: 40),
    //   ],
    // );
  }
}

// Container(
//       height: 90,
//       margin: EdgeInsets.only(right: 110),
//       decoration: BoxDecoration(
//         color: col_aqua_dark2,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: kElevationToShadow[16],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           SizedBox(
//             width: 52,
//             height: 52,
//             child: FloatingActionButton(
//               backgroundColor: Colors.grey,
//               elevation: 0,
//               child: Icon(Icons.delete),
//               onPressed: () {},
//             ),
//           ),
//           SizedBox(
//             width: 52,
//             height: 52,
//             child: FloatingActionButton(
//               backgroundColor: col_aqua_light,
//               elevation: 0,
//               child: Icon(Icons.arrow_back),
//               onPressed: () {},
//             ),
//           ),
//           SizedBox(
//             width: 72,
//             height: 72,
//             child: FloatingActionButton(
//               backgroundColor: col_aqua_light,
//               elevation: 0,
//               child: Icon(Icons.arrow_forward, size: 36),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//     );
