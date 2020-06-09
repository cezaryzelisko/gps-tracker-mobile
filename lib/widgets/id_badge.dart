import 'package:flutter/material.dart';

class IDBadge extends StatelessWidget {
  final int id;

  IDBadge(this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Theme.of(context).accentColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text('ID: $id'),
    );
  }
}
