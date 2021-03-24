import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class PasswordTextEdit extends StatefulWidget {
  final TextEditingController controller;

  PasswordTextEdit(this.controller);

  @override
  _PasswordTextEditState createState() => _PasswordTextEditState();
}

class _PasswordTextEditState extends State<PasswordTextEdit> {
  bool _showPassword = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: TextField(
        obscureText: !_showPassword,
        controller: _controller,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20, height: 1.0),
        decoration: UtilWidget.txtInputDecor(
            '',
            AppIconsUsed.openLock,
            IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: this._showPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() => this._showPassword = !this._showPassword);
              },
            )),
      ),
    );
  }
}
