import 'package:flutter/material.dart';
import '../helpers/colors.dart';

// const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
// const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
// const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

class DisplayAmount extends StatefulWidget {
  _DisplayAmountState createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '\$77.00',
        style: TextStyle(
          fontSize: 25,
          letterSpacing: 1.1,
          color: Colors.white,
        ),
      ),
    );
  }
}
