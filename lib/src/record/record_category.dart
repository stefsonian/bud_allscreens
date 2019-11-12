import 'package:allscreens/src/components/splitter.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color col_content = col_aqua;
const Color col_back = Colors.white;

class RecordCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 2,
            left: 0,
            right: 0,
            child: Splitter(
              label: 'Expense category',
              icon: Icons.select_all,
              padding: EdgeInsets.all(0),
              showLine: false,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Categories
              Expanded(child: CategorySelector()),
              // Smart suggestions
              Column(
                children: <Widget>[
                  Splitter(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    icon: Icons.lightbulb_outline,
                    label: 'Smart suggestions',
                    // showLine: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _IconButton(icon: Icons.restaurant, label: 'Breakfast'),
                      _IconButton(icon: Icons.train, label: 'Train'),
                      _IconButton(
                        icon: Icons.shopping_cart,
                        label: 'Groceries',
                        isSelected: true,
                      ),
                      _IconButton(icon: Icons.hotel, label: 'Hotel'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _category(Icons.restaurant),
                  _category(Icons.hotel),
                  _category(Icons.train),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _category(Icons.camera_alt),
                  _category(Icons.scatter_plot),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _category(IconData icon) {
    return Container(
      height: 60,
      width: 60,
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: FittedBox(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({Key key, this.icon, this.isSelected = false, this.label})
      : super(key: key);
  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSelected ? buildSelected() : buildNormal(),
    );
  }

  Widget buildNormal() {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 26,
          color: Colors.white.withOpacity(0.6),
        ),
        SizedBox(height: 1),
        Text(label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11)),
      ],
    );
  }

  Widget buildSelected() {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          size: 26,
          color: Colors.white,
        ),
        SizedBox(height: 1),
        Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
