import 'package:flutter/material.dart';

enum SortOptions {
  newest,
  oldest,
}

class SortMenu extends StatefulWidget {
  final String label;
  final SortOptions defaultOption;

  SortMenu(Key key, this.label, [this.defaultOption = SortOptions.newest]) : super(key: key);

  @override
  SortMenuState createState() => SortMenuState();
}

class SortMenuState extends State<SortMenu> {
  SortOptions option;

  void initState() {
    super.initState();
    option = widget.defaultOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label),
        ListTile(
          title: Text('from newest'),
          leading: Radio<SortOptions>(
            value: SortOptions.newest,
            groupValue: option,
            onChanged: (value) {
              setState(() {
                option = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              option = SortOptions.newest;
            });
          },
        ),
        ListTile(
          title: Text('from oldest'),
          leading: Radio<SortOptions>(
            value: SortOptions.oldest,
            groupValue: option,
            onChanged: (value) {
              setState(() {
                option = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              option = SortOptions.oldest;
            });
          },
        ),
      ],
    );
  }
}
