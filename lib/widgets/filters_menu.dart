import 'package:flutter/material.dart';

enum FiltersOptions {
  fixed,
  date,
}

class FiltersMenu extends StatefulWidget {
  final String groupLabel;
  final String fixedLabel;
  final DateTime initialDate;

  const FiltersMenu(Key key, this.groupLabel, this.fixedLabel, this.initialDate) : super(key: key);

  @override
  FiltersMenuState createState() => FiltersMenuState();
}

class FiltersMenuState extends State<FiltersMenu> {
  final firstDate = DateTime(2020, 1, 1);
  final lastDate = DateTime.now().add(Duration(days: 366));
  DateTime date;
  FiltersOptions _option;
  var _dateEnabled = false;

  String formatDate(DateTime date) {
    if (date == null) {
      return 'choose date';
    } else {
      return date.toLocal().toString().split(' ')[0];
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _option = FiltersOptions.date;
      date = widget.initialDate;
      _dateEnabled = true;
    } else {
      _option = FiltersOptions.fixed;
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
          leading: Radio<FiltersOptions>(
            value: FiltersOptions.fixed,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _option = FiltersOptions.fixed;
              _dateEnabled = false;
            });
          },
        ),
        ListTile(
          title: Text('custom date:'),
          leading: Radio<FiltersOptions>(
            value: FiltersOptions.date,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          trailing: FlatButton(
            color: Theme.of(context).accentColor,
            child: Text(formatDate(date)),
            onPressed: _dateEnabled
                ? () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: widget.initialDate != null ? widget.initialDate : DateTime.now(),
                      firstDate: firstDate,
                      lastDate: lastDate,
                    );
                    setState(() {
                      date = pickedDate;
                    });
                  }
                : null,
          ),
          onTap: () {
            setState(() {
              _option = FiltersOptions.date;
              _dateEnabled = true;
            });
          },
        ),
      ],
    );
  }
}
