import 'package:flutter/material.dart';

class EditParticipantsScreen extends StatelessWidget {
  final List<String> entries = <String>['Lynda', 'Jayne', 'Porter'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: FlutterLogo(),
            title: Text(entries[index]),
            trailing: Icon(Icons.more_vert),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
