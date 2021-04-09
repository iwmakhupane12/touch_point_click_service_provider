import 'package:flutter/material.dart';
import 'dart:async';

import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/picker.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:touch_point_click_service_provider/src/components/loadingPopUp.dart';

import 'package:touch_point_click_service_provider/src/screens/signInUp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    initCountry('ZA');
  }

  Country _userCountry;

  void initCountry(String userCallCode) async {
    final country = await getCountryByCountryCode(context, userCallCode);
    if (country != null) {
      setState(() {
        _userCountry = country;
      });
      Timer(Duration(seconds: 5), () => changeScreen());
    }
  }

  void changeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInUp(_userCountry),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double topPad = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, topPad, 8.0, 0.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    image: new DecorationImage(
                      image: AssetImage('assets/images/logo_text_vertical.png'),
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(width: 0.5, color: Colors.grey),
                    color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new LoadingPopUp(loadingColor: Colors.white),
                /*CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),*/
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
                  child: Flex(direction: Axis.horizontal, children: <Widget>[
                    Expanded(
                      child: Text(
                        'We Bring Services At The Palm Of Your Hand',
                        style: AppTextStyles.bodyNormalWhiteSmall(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                ),*/
                SizedBox(height: 20.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
