import 'package:flutter/material.dart';

class DialogueDraft extends StatefulWidget {
  @override
  _DialogueDraftState createState() => _DialogueDraftState();
}

class _DialogueDraftState extends State<DialogueDraft> {
  String _selectedId;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Test"),
        ),
        body: new ListView(padding: const EdgeInsets.all(32.0), children: [
          new Container(
              padding: const EdgeInsets.all(10.0),
              child: new DropdownButton<String>(
                hint: const Text("Pick a thing"),
                value: _selectedId,
                onChanged: (String value) {
                  setState(() {
                    _selectedId = value;
                  });
                },
                items:
                    <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
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

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  String _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialValue;
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: new Text("New Dialog"),
      children: <Widget>[
        new Container(
            padding: const EdgeInsets.all(10.0),
            child: new DropdownButton<String>(
              hint: const Text("Pick a thing"),
              value: _selectedId,
              onChanged: (String value) {
                setState(() {
                  _selectedId = value;
                });
                widget.onValueChange(value);
              },
              items:
                  <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            )),
      ],
    );
  }
}
