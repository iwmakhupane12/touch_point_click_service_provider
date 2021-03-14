import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class DialogueDraft extends StatefulWidget {
  @override
  _DialogueDraftState createState() => _DialogueDraftState();
}

class _DialogueDraftState extends State<DialogueDraft> {
  int _selectedId;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Test"),
        ),
        body: new ListView(padding: const EdgeInsets.all(32.0), children: [
          new Container(
              padding: const EdgeInsets.all(10.0),
              child: new DropdownButton<int>(
                hint: const Text("Pick a thing"),
                value: _selectedId,
                onChanged: (int value) {
                  setState(() {
                    _selectedId = value;
                  });
                },
                items: <int>[1, 2, 3, 4].map((int value) {
                  return new DropdownMenuItem<int>(
                    value: value,
                    child: new Text("$value"),
                  );
                }).toList(),
              )),
        ]),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          tooltip: "New Dialog",
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => new MyDialog(
                      onValueChange: _onValueChange,
                      initialValue: _selectedId,
                    ));
          },
        ));
  }

  void _onValueChange(int value) {
    setState(() {
      _selectedId = value;
    });
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue});

  final int initialValue;
  final void Function(int) onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  int _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text("New Dialog"),
      children: <Widget>[
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 1,
              groupValue: _selectedId,
              onChanged: (value) {
                setState(() {
                  _selectedId = value;
                });
                widget.onValueChange(value);
              },
            ),
          ),
          title: textToCheck("By Range", FontWeight.normal),
        ),
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: 2,
              groupValue: _selectedId,
              onChanged: (value) {
                setState(() {
                  _selectedId = value;
                });
                widget.onValueChange(value);
              },
            ),
          ),
          title: textToCheck("Singular", FontWeight.normal),
        ),
      ],
    );
  }

  Widget textToCheck(String text, FontWeight fontWeight) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.normalBlack(fontWeight, Colors.black),
      ),
    );
  }
}
