import 'package:flutter/material.dart';
import 'package:gps_tracker_mobile/providers/gps_footprint_provider.dart';
import 'package:provider/provider.dart';

import 'package:gps_tracker_mobile/utils/datetime_utils.dart';

enum FilterDateOptions {
  fixed,
  date,
}

class FilterDateMenu extends StatefulWidget {
  final String groupLabel;
  final String fixedLabel;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const FilterDateMenu(
    Key key,
    this.groupLabel,
    this.fixedLabel,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  ) : super(key: key);

  @override
  FilterDateMenuState createState() => FilterDateMenuState();
}

class FilterDateMenuState extends State<FilterDateMenu> {
  DateTime _date;
  FilterDateOptions _option;
  var _dateEnabled = false;

  DateTime get date {
    if (_option == FilterDateOptions.fixed) {
      return null;
    }
    return _date;
  }

  String _formatDate() {
    if (_date == null) {
      return 'choose date';
    } else {
      return formatDateTime(_date, withTime: false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _option = FilterDateOptions.date;
      _date = widget.initialDate;
      _dateEnabled = true;
    } else {
      _option = FilterDateOptions.fixed;
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
          leading: Radio<FilterDateOptions>(
            value: FilterDateOptions.fixed,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _option = FilterDateOptions.fixed;
              _dateEnabled = false;
            });
          },
        ),
        ListTile(
          title: Text('custom date:'),
          leading: Radio<FilterDateOptions>(
            value: FilterDateOptions.date,
            groupValue: _option,
            onChanged: (value) {
              setState(() {
                _option = value;
              });
            },
          ),
          trailing: FlatButton(
            color: Theme.of(context).accentColor,
            child: Text(_formatDate()),
            onPressed: _dateEnabled
                ? () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: widget.initialDate != null ? widget.initialDate : widget.firstDate,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                    );
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                : null,
          ),
          onTap: () {
            setState(() {
              _option = FilterDateOptions.date;
              _dateEnabled = true;
            });
          },
        ),
      ],
    );
  }
}

class FilterCheckboxMenu extends StatefulWidget {
  final List<int> itemsChecked;

  FilterCheckboxMenu(Key key, this.itemsChecked) : super(key: key);

  @override
  FilterCheckboxMenuState createState() => FilterCheckboxMenuState();
}

class FilterCheckboxMenuState extends State<FilterCheckboxMenu> {
  List<int> checked;

  @override
  void initState() {
    super.initState();
    checked = widget.itemsChecked != null ? widget.itemsChecked : getPossibleIDs(context);
  }

  List<int> getPossibleIDs(BuildContext context) {
    var gpsFootprints = Provider.of<GPSFootprintProvider>(context, listen: false).gpsFootprints;
    return gpsFootprints.map((gpsFootprint) => gpsFootprint.deviceID).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    var checkboxes = getPossibleIDs(context)
        .map(
          (id) => CheckboxListTile(
            title: Text('Device ID: $id'),
            value: checked.indexOf(id) != -1,
            onChanged: (value) {
              if (value) {
                setState(() {
                  checked.add(id);
                });
              } else {
                setState(() {
                  checked.remove(id);
                });
              }
            },
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: checkboxes,
    );
  }
}
