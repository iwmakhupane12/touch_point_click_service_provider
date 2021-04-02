import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class PhoneNumEditText extends StatefulWidget {
  final TextEditingController controller;
  final Country country;

  PhoneNumEditText(this.controller, this.country);

  @override
  _PhoneNumEditTextState createState() => _PhoneNumEditTextState();
}

class _PhoneNumEditTextState extends State<PhoneNumEditText> {
  TextEditingController _controller;
  Country _country;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _country = widget.country;
  }

  @override
  Widget build(BuildContext context) {
    return txtInputText();
  }

  Widget txtInputText() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Row(
        children: [
          countryWithCode(),
          Flexible(
            child: TextField(
              controller: _controller,
              enabled: true,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 20, height: 1.0),
              decoration: UtilWidget.txtInputDecor("071 456 7892", null, null),
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _country = country;
      });
    }
  }

  Widget countryWithCode() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: null,
        child: GestureDetector(
          onTap: () => _showCountryPicker(),
          child: Row(
            children: [
              Image.asset(
                _country.flag,
                package: countryCodePackageName,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  _country == null
                      ? ''
                      : '(${_country?.callingCode ?? '+code'})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down_sharp,
                  color: Colors.black, size: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
