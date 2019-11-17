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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Splitter(
          //   label: 'Category',
          //   icon: Icons.select_all,
          //   padding: EdgeInsets.only(bottom: 20),
          //   showLine: true,
          // ),
          // Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CatButton(icon: Icons.flash_on, label: 'Quick', isMainCat: true),
              CatButton(
                icon: Icons.restaurant,
                label: 'Eat',
                showLabel: false,
                isMainCat: true,
                isDimmed: true,
              ),
              CatButton(
                icon: Icons.hotel,
                label: 'Sleep',
                showLabel: false,
                isMainCat: true,
                isDimmed: true,
              ),
              CatButton(
                icon: Icons.train,
                label: 'Travel',
                showLabel: false,
                isMainCat: true,
                isDimmed: true,
              ),
              CatButton(
                icon: Icons.camera_alt,
                label: 'See',
                showLabel: false,
                isMainCat: true,
                isDimmed: true,
              ),
              CatButton(
                icon: Icons.scatter_plot,
                label: 'Other',
                showLabel: false,
                isMainCat: true,
                isDimmed: true,
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
          SizedBox(height: 20),
          // Smart suggestions
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                CatButton(icon: Icons.restaurant, label: 'Breakfast'),
                CatButton(icon: Icons.train, label: 'Train'),
                CatButton(icon: Icons.shopping_cart, label: 'Groceries'),
                CatButton(icon: Icons.hotel, label: 'Hotel'),
                CatButton(icon: Icons.map, label: 'Hike'),
                CatButton(icon: Icons.local_drink, label: 'Drink'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
        ],
      ),
    );
  }
}

class CatButton extends StatefulWidget {
  const CatButton(
      {Key key,
      this.icon,
      this.label,
      this.isMainCat = false,
      this.isDimmed = false,
      this.showLabel = true})
      : super(key: key);
  final IconData icon;
  final String label;
  final bool isMainCat;
  final isDimmed;
  final showLabel;

  @override
  _CatButtonState createState() => _CatButtonState();
}

class _CatButtonState extends State<CatButton> {
  @override
  Widget build(BuildContext context) {
    var iconOpacity = widget.isDimmed ? 0.7 : 1.0;
    var labelOpacity = widget.isDimmed ? 0.7 : 1.0;
    if (widget.isMainCat && !widget.showLabel) labelOpacity = 0.0;
    return Container(
      width: widget.isMainCat ? null : 85,
      child: Column(
        verticalDirection:
            widget.isMainCat ? VerticalDirection.up : VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 30,
            color: Colors.white.withOpacity(iconOpacity),
          ),
          SizedBox(height: 5),
          Text(
            widget.label,
            style: TextStyle(
                color: Colors.white.withOpacity(labelOpacity), fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
