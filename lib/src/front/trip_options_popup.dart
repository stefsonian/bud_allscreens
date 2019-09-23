import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

enum TripOption { edit, change, add, invite }

class TripOptionsPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TripOption>(
      onSelected: (TripOption result) {
        switch (result) {
          case TripOption.edit:
            Navigator.pushNamed(context, 'edit trip');
            break;
          case TripOption.change:
            Navigator.pushNamed(context, 'edit trip');
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
            color: col_aqua_dark2,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.change,
          child: _PopupItem(
            label: 'Change trip',
            icon: Icons.compare_arrows,
            color: col_aqua_dark2,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.add,
          child: _PopupItem(
            label: 'New trip',
            icon: Icons.add,
            color: col_aqua_dark2,
          ),
        ),
        const PopupMenuItem<TripOption>(
          value: TripOption.invite,
          child: _PopupItem(
            label: 'Invite traveller',
            icon: Icons.person_add,
            color: col_aqua_dark2,
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
