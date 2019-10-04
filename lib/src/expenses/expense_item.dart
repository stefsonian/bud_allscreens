import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/components/info_bubble.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({Key key, this.note}) : super(key: key);
  final String note;

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      padding: EdgeInsets.fromLTRB(0, 6, 12, 6),
      child: Row(
        children: <Widget>[
          IkonButton(
            backColor: Colors.white,
            color: col_aqua,
            elevation: 0.0,
            icon: Icons.camera,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Entertainment',
                  style: TextStyle(
                    fontSize: 16,
                    color: col_aqua,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.fade,
                ),
                Text(
                  '27 Sep 19',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    letterSpacing: 1.1,
                  ),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  print('h2: ${constraints.maxHeight}');
                  print('w2: ${constraints.maxWidth}');
                  return Container();
                }),
                note == null
                    ? Container()
                    : Text(
                        "I'm just a little note but I'm very important. It's good I'm here",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          letterSpacing: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
          Container(
            width: 90,
            alignment: Alignment.centerRight,
            child: Text(
              '\$46.88',
              style: TextStyle(
                fontSize: 18,
                color: col_aqua,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Flexible(
//             child: Row(
//               children: <Widget>[
//                 IkonButton(
//                   backColor: Colors.white,
//                   color: col_aqua,
//                   elevation: 0.0,
//                   icon: Icons.camera,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Entertainment',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: col_aqua,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.1,
//                       ),
//                       overflow: TextOverflow.fade,
//                     ),
//                     Text(
//                       '27 Sep 19',
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                         letterSpacing: 1.1,
//                       ),
//                     ),
//                     LayoutBuilder(builder: (context, constraints) {
//                       print('h: ${constraints.maxHeight}');
//                       print('w: ${constraints.maxWidth}');
//                       return Container();
//                     }),
//                     Container(
//                       child: Text(
//                         "I'm just a little note - but I'm very important!",
//                         style: TextStyle(
//                           fontSize: 13,
//                           color: Colors.black87,
//                           letterSpacing: 1.1,
//                         ),
//                         // overflow: TextOverflow.fade,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               width: 100,
//               alignment: Alignment.centerRight,
//               child: Text('\$46.88', textScaleFactor: 1.4)),
//         ],
//       ),