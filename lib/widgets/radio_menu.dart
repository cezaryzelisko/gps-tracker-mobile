import 'package:flutter/material.dart';

enum MenuOptions {
  fixed,
  date,
}

class RadioMenu extends StatefulWidget {
  final String groupLabel;
  final String fixedLabel;
  final DateTime initialDate;

  const RadioMenu(Key key, this.groupLabel, this.fixedLabel, this.initialDate) : super(key: key);

  @override
  RadioMenuState createState() => RadioMenuState();
}

class RadioMenuState extends State<RadioMenu> {
  final firstDate = DateTime(2020, 1, 1);
  final lastDate = DateTime.now().add(Duration(days: 366));
  DateTime date;
  MenuOptions _option = MenuOptions.fixed;
  var _dateEnabled = false;

  String formatDate(DateTime date) {
    if (date == null) {
      return 'choose date';
    } else {
      return date.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.groupLabel),
        ListTile(
          title: Text(widget.fixedLabel),
          leading: Radio<MenuOptions>(
            value: MenuOptions.fixed,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _option = MenuOptions.fixed;
              _dateEnabled = false;
            });
          },
        ),
        ListTile(
          title: Text('custom date'),
          leading: Radio<MenuOptions>(
            value: MenuOptions.date,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          trailing: FlatButton(
            child: Text(formatDate(date)),
            onPressed: _dateEnabled ? () async {
              var pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.initialDate,
                firstDate: firstDate,
                lastDate: lastDate,
              );
              setState(() {
                date = pickedDate;
              });
            } : null,
          ),
          onTap: () {
            setState(() {
              _option = MenuOptions.date;
              _dateEnabled = true;
            });
          },
        ),
      ],
    );
  }
}
