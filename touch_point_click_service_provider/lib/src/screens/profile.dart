import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/profileImage.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';

class Profile extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Profile(this.onlineOfflineAppBar);

  @override
  _ProfileState createState() => _ProfileState();
}

final FontWeight normal = FontWeight.normal;
final FontWeight bold = FontWeight.bold;

final Color black = Colors.black;
final Color white = Colors.white;

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileImage _profileImage;

  TextEditingController _nameController,
      _phoneNumController,
      _altPhoneNumController,
      _emailController,
      _passwordController,
      _addressController;

  void initControllers() {
    _nameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _altPhoneNumController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    initControllers();
    _profileImage = ProfileImage();
    actions.add(actionsWidget());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumController.dispose();
    _altPhoneNumController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      displayBody(),
      null,
      "Profile",
      widget.onlineOfflineAppBar,
      null,
      actions,
    );
  }

  /*Widget appBarBackButton() {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Home(onlineOfflineAppBar: widget.onlineOfflineAppBar),
        ),
      ),
      child: AppIconsUsed.appBarIcon,
    );
  }*/

  List<Widget> actions = [];

  Widget actionsWidget() {
    return this._editUserProfile
        ? Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                updateData();
              },
              child: Text("Update",
                  style: AppTextStyles.normalBlack(normal, black),
                  overflow: TextOverflow.ellipsis),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("Update",
                  style: AppTextStyles.normalBlack(normal, Colors.grey),
                  overflow: TextOverflow.ellipsis),
            ),
          );
  }

  void updateData() {
    setState(() {
      this._editUserProfile = false;
      actions = [];
      actions.add(actionsWidget());
    });
  }

  Widget displayBody() {
    return ListView(
      children: [
        _profileImage,
        Divider(),
        profileNotVerified(),
        Divider(),
        personalInfoHeader(),
        headerText("Service Provider Name"),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText("", AppIconsUsed.personIcon,
              _nameController, TextInputType.emailAddress, _editUserProfile),
        ),
        headerText("Phone Number"),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText(
              "",
              AppIconsUsed.phoneIcon,
              _phoneNumController,
              TextInputType.emailAddress,
              _editUserProfile),
        ),
        headerText("Alternative Phone Number"),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText(
              "",
              AppIconsUsed.phoneIcon,
              _altPhoneNumController,
              TextInputType.emailAddress,
              _editUserProfile),
        ),
        headerText("Email Address"),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText("", AppIconsUsed.emailIcon,
              _emailController, TextInputType.emailAddress, _editUserProfile),
        ),
        headersInRow("Password", 2),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText("", AppIconsUsed.closedLock,
              _passwordController, TextInputType.emailAddress, false),
        ),
        headersInRow("Business Address", 3),
        Padding(
          padding: padding,
          child: UtilWidget.txtInputText("", AppIconsUsed.workIcon,
              _addressController, TextInputType.emailAddress, false),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10.0);

  Widget headersInRow(String text, int editBtn) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerText(text),
        this._editUserProfile
            ? Padding(
                padding: padding,
                child: editButton(editBtn),
              )
            : new Container(),
      ],
    );
  }

  Widget profileNotVerified() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          verificationRow("Account"),
          verificationRow("Phone number"),
          verificationRow("Email address"),
        ],
      ),
    );
  }

  Widget verificationRow(String verify) {
    String whichVeri = verify;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$whichVeri is not verified",
            style: AppTextStyles.normalBlack(normal, Colors.red),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            verificationClicked(whichVeri);
          },
          style: UtilWidget.buttonStyle,
          child: Text(
            "Verify Now",
            style: AppTextStyles.normalBlackSmall(normal, white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void verificationClicked(String whichVeri) {}

  Widget headerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget personalInfoHeader() {
    return Padding(
      padding: padding,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "Personal Information",
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            !this._editUserProfile ? editButton(1) : new Container(),
          ]),
    );
  }

  bool _editUserProfile = false;

  Widget editButton(int editBtn) {
    int whichClicked = editBtn;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: GestureDetector(
        child: new CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 14.0,
          child: new Icon(
            Icons.edit,
            color: Colors.white,
            size: 16.0,
          ),
        ),
        onTap: () {
          setState(
            () {
              switch (whichClicked) {
                case 1:
                  {
                    _editUserProfile = true;
                    actions = [];
                    actions.add(actionsWidget());
                  }
                  break;
                case 2:
                  {}
                  break;
                case 3:
                  {}
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
