import 'package:flutter/material.dart';

class ListWithFilters extends StatelessWidget {
  final _items = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Filters'),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => Text('item $index'),
            itemCount: _items.length,
          ),
        ),
      ],
    );
  }
}
