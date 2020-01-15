import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TripOption { edit, change, add, invite }

class TripOptionsPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return PopupMenuButton<TripOption>(
      icon: Icon(Icons.edit, color: appState.cols.content),
      onSelected: (TripOption result) {
        appState.showQuickAddButton = false;
        switch (result) {
          case TripOption.edit:
            Navigator.pushNamed(context, 'edit trip');
            break;
          case TripOption.change:
            Navigator.pushNamed(context, 'select trip');
            break;
          case TripOption.add:
            Navigator.pushNamed(context, 'edit trip');
            break;
          case TripOption.invite:
            Navigator.pushNamed(context, 'edit participants');
            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TripOption>>[
        const PopupMenuItem<TripOption>(
          value: TripOption.edit,
          child: _PopupItem(
            label: 'Edit trip',
            icon: Icons.edit,
            color: col_main3,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.change,
          child: _PopupItem(
            label: 'Change trip',
            icon: Icons.compare_arrows,
            color: col_main3,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.add,
          child: _PopupItem(
            label: 'New trip',
            icon: Icons.add,
            color: col_main3,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.invite,
          child: _PopupItem(
            label: 'Trip companions',
            icon: Icons.person_add,
            color: col_main3,
          ),
        ),
      ],
    );
  }
}

class _PopupItem extends StatelessWidget {
  const _PopupItem({Key key, this.icon, this.label, this.color})
      : super(key: key);

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              icon,
              color: color,
            ),
          ),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
