import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class DurationSetDialog extends StatefulWidget {
  final Widget text;
  final Duration initialDuration;

  DurationSetDialog({this.text, this.initialDuration});

  @override
  _DurationSetDialogState createState() =>
      _DurationSetDialogState(initialDuration);
}

class _DurationSetDialogState extends State<DurationSetDialog> {
  int minutes=0;
  int seconds=0;

  _DurationSetDialogState(Duration initialDuration) {
    minutes = initialDuration.inMinutes;
  seconds=initialDuration.inSeconds%Duration.secondsPerMinute;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.text,
      content: Row(
        children: <Widget>[
          NumberPicker.integer(
              zeroPad: true,
              initialValue: minutes,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) {
                setState(() {
                  minutes = value;
                });
              }),
          Text(':'),
          NumberPicker.integer(
              zeroPad: true,
              initialValue: seconds,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) {
                setState(() {
                  seconds = value;
                });
              }),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(
                Duration(seconds: seconds, minutes: minutes),
              );
            },
            child: Text('ok')),
      ],
    );
  }
}
