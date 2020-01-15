import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class CurvedBox extends StatelessWidget {
  const CurvedBox(
      {Key key, this.child, this.topArc = true, this.bottomArc = true})
      : super(key: key);
  final bool topArc;
  final bool bottomArc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FrontBoxClipper(topArc, bottomArc),
      child: child,
    );
  }
}

class FrontBoxClipper extends CustomClipper<Path> {
  FrontBoxClipper(this.topArc, this.bottomArc);
  final bool topArc;
  final bool bottomArc;

  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;

    final path = Path();

    if (bottomArc) {
      path.lineTo(0, h - 50);
      path.quadraticBezierTo(w * 0.5, h, w, h - 50);
      path.lineTo(w, 0);
    } else {
      path.lineTo(0, h);
      path.lineTo(w, h);
      path.lineTo(w, 0);
    }

    if (topArc) {
      path.quadraticBezierTo(w * 0.5, 50, 0, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(FrontBoxClipper oldClipper) => true;
}
