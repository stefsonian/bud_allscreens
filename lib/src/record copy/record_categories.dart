import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color col_content = col_aqua;
const Color col_back = Colors.white;

class RecordMainCategory extends StatelessWidget {
  Widget build(BuildContext context) {
    final RecordState recordState = Provider.of<RecordState>(context);
    return Center(
      key: Key('mainCat'),
      child: GestureDetector(
        onTap: () => recordState.isMainCatRecorded = true,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IkonButton(
                    icon: Icons.restaurant,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.hotel,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.train,
                    color: col_content,
                    backColor: col_back,
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IkonButton(
                    icon: Icons.camera_alt,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.scatter_plot,
                    color: col_content,
                    backColor: col_back,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Text(
                'Choose a category',
                style: TextStyle(
                  color: col_content,
                  fontSize: 20,
                  wordSpacing: 2,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordSubCategory extends StatelessWidget {
  Widget build(BuildContext context) {
    final RecordState recordState = Provider.of<RecordState>(context);
    return Center(
      key: Key('subCats'),
      child: GestureDetector(
        onTap: () => recordState.isSubCatRecorded = true,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IkonButton(
                    icon: Icons.train,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.tram,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.directions_bus,
                    color: col_content,
                    backColor: col_back,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IkonButton(
                    icon: Icons.directions_subway,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.flight,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.directions_boat,
                    color: col_content,
                    backColor: col_back,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IkonButton(
                    icon: Icons.directions_car,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.directions_bike,
                    color: col_content,
                    backColor: col_back,
                  ),
                  IkonButton(
                    icon: Icons.directions_run,
                    color: col_content,
                    backColor: col_back,
                  ),
                ],
              ),
              SizedBox(height: 60),
              Text(
                'Choose a sub-category',
                style: TextStyle(
                  color: col_content,
                  fontSize: 20,
                  wordSpacing: 2,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
