import 'package:flutter/material.dart';

const List<IconData> icons = [
  Icons.restaurant,
  Icons.hotel,
  Icons.train,
  Icons.camera_alt,
  Icons.scatter_plot
];
const List<String> amounts = ['\$33', '\$76', '\$7', '\$25', '\$4'];

class BudgetToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Icon(Icons.donut_large),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ...[0, 1, 2, 3, 4]
                  .map((i) => BudgetIcon(icon: icons[i], amount: amounts[i]))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}

class BudgetIcon extends StatelessWidget {
  const BudgetIcon({Key key, this.icon, this.amount}) : super(key: key);
  final IconData icon;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(icon),
          ),
        ),
        SizedBox(height: 8),
        Text(amount, textScaleFactor: 0.8),
      ],
    );
  }
}
