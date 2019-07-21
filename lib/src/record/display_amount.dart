import 'package:flutter/material.dart';
import '../helpers/colors.dart';

const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

class DisplayAmount extends StatefulWidget {
  @override
  _DisplayAmountState createState() => _DisplayAmountState();
}

class _DisplayAmountState extends State<DisplayAmount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: col_background1,
        boxShadow: kElevationToShadow[6],
      ),
    );
  }
}
