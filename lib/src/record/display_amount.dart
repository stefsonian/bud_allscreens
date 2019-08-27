import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:flutter/material.dart';
import '../helpers/colors.dart';

// const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
// const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
// const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

class DisplayAmount extends StatefulWidget {
  const DisplayAmount({this.col1, this.col2});
  final Color col1;
  final Color col2;

  _DisplayAmountState createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  Widget build(BuildContext context) {
    return GradientBoxSimple(
      child: _DisplayAmount(amount: '77.30', prefix: '\$'),
    );
  }
}

class _DisplayAmount extends StatelessWidget {
  const _DisplayAmount({this.amount, this.prefix});
  final String amount;
  final String prefix;

  Widget build(BuildContext context) {
    return Stack(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Positioned(
          left: 0,
          child: RaisedButton(
            onPressed: () {},
            child: Text('AUD'),
            // icon: Icon(Icons.donut_small),
            color: col_purple,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
          ),
        ),
        Center(
          child: Text(
            '$prefix$amount',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 2.0,
              color: col_purple,
            ),
          ),
        ),
      ],
    );
  }
}
