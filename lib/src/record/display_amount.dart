import 'package:flutter/material.dart';
import '../helpers/colors.dart';

// const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
// const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
// const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

class DisplayAmount extends StatefulWidget {
  @override
  _DisplayAmountState createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight > 850 ? 62 : 58,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: col_background1,
        boxShadow: kElevationToShadow[3],
      ),
      child: _DisplayAmount(amount: '77.30', prefix: '\$'),
    );
  }
}

class _DisplayAmount extends StatelessWidget {
  const _DisplayAmount({this.amount, this.prefix});
  final String amount;
  final String prefix;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$prefix$amount',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            letterSpacing: 2.0,
            color: col_box2,
          ),
        ),
      ],
    );
  }
}
