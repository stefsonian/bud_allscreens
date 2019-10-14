import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'dart:math';

class DayBox extends StatelessWidget {
  const DayBox({Key key, this.color, this.child}) : super(key: key);
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DayClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 12),
        color: color,
        child: child,
      ),
    );
  }

  final TextStyle _styleDateHeader = const TextStyle(
      fontSize: 18, letterSpacing: 1.1, wordSpacing: 1.5, color: Colors.white);
}

class _ExpenseItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _BoxDateHeader extends StatelessWidget {
  const _BoxDateHeader({Key key, this.color, this.child}) : super(key: key);
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(16, 10, 12, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
              color: Colors.black54),
          child: child,
        ),
      ),
    );
  }
}

class DayClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 70);
    // path.lineTo(0.0, 200.0);
    path.quadraticBezierTo(
        size.width * 0.3, size.height, size.width * 0.6, size.height - 50);
    // path.quadraticBezierTo(size.width * 0.3, 270, size.width * 0.6, 220);
    path.quadraticBezierTo(
        size.width * 0.85, size.height - 90, size.width, size.height - 70);
    // path.quadraticBezierTo(size.width * 0.85, 180, size.width, 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DayClipper oldClipper) => false;
}

// const CURVE_HEIGHT = 160.0;
// const AVATAR_RADIUS = CURVE_HEIGHT * 0.28;
// const AVATAR_DIAMETER = AVATAR_RADIUS * 2;

// class CurvedShape extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 200,
//       child: CustomPaint(
//         painter: _MyPainter(),
//       ),
//     );
//   }
// }

// class _MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..style = PaintingStyle.fill
//       ..isAntiAlias = true
//       ..color = Colors.purple[700];

//     Offset circleCenter = Offset(size.width / 2, size.height - AVATAR_RADIUS);

//     Offset topLeft = Offset(0, 0);
//     Offset bottomLeft = Offset(0, size.height * 0.25);
//     Offset topRight = Offset(size.width, 0);
//     Offset bottomRight = Offset(size.width, size.height * 0.5);

//     Offset leftCurveControlPoint =
//         Offset(circleCenter.dx * 0.5, size.height - AVATAR_RADIUS * 1.5);
//     Offset rightCurveControlPoint =
//         Offset(circleCenter.dx * 1.6, size.height - AVATAR_RADIUS);

//     final arcStartAngle = 200 / 180 * pi;
//     final avatarLeftPointX =
//         circleCenter.dx + AVATAR_RADIUS * cos(arcStartAngle);
//     final avatarLeftPointY =
//         circleCenter.dy + AVATAR_RADIUS * sin(arcStartAngle);
//     Offset avatarLeftPoint =
//         Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

//     final arcEndAngle = -5 / 180 * pi;
//     final avatarRightPointX =
//         circleCenter.dx + AVATAR_RADIUS * cos(arcEndAngle);
//     final avatarRightPointY =
//         circleCenter.dy + AVATAR_RADIUS * sin(arcEndAngle);
//     Offset avatarRightPoint = Offset(
//         avatarRightPointX, avatarRightPointY); // the right point of the arc

//     Path path = Path()
//       ..moveTo(topLeft.dx,
//           topLeft.dy) // this move isn't required since the start point is (0,0)
//       ..lineTo(bottomLeft.dx, bottomLeft.dy)
//       ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
//           avatarLeftPoint.dx, avatarLeftPoint.dy)
//       ..arcToPoint(avatarRightPoint, radius: Radius.circular(AVATAR_RADIUS))
//       ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
//           bottomRight.dx, bottomRight.dy)
//       ..lineTo(topRight.dx, topRight.dy)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
