import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            height: 80,
            width: 80,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
