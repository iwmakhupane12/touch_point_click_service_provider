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
    return Row(
      children: [
        countryWithCode(),
        Flexible(
          child: UtilWidget.txtInputText(
            "071 456 7892",
            null,
            _controller,
            TextInputType.phone,true
          ),
        ),
      ],
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
    return Container(
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
                _country == null ? '' : '(${_country?.callingCode ?? '+code'})',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
