import 'package:flutter/material.dart';

enum SortOptions {
  newest,
  oldest,
  device_id_az,
  device_id_za,
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

  ListTile getSortOptionWidget(String label, SortOptions sortOption) {
    return ListTile(
      title: Text(label),
      leading: Radio<SortOptions>(
        value: sortOption,
        groupValue: option,
        onChanged: (value) {
          setState(() {
            option = value;
          });
        },
      ),
      onTap: () {
        setState(() {
          option = sortOption;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.label),
        getSortOptionWidget('from newest', SortOptions.newest),
        getSortOptionWidget('from oldest', SortOptions.oldest),
        getSortOptionWidget('device ID A->Z', SortOptions.device_id_az),
        getSortOptionWidget('device ID Z->A', SortOptions.device_id_za),
      ],
    );
  }
}
