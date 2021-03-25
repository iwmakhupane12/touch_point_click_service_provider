import 'dart:io';

import 'package:flutter/material.dart';

import 'package:images_picker/images_picker.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class ProfileImage extends StatefulWidget {
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return userProfileImage();
  }

  String path;

  Widget userProfileImage() {
    ImageProvider profileImg = path != null
        ? FileImage(File(path))
        : ExactAssetImage('assets/images/profilePlaceholder.png');

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                //ViewAppImageScreen.showSecondPage(context, profileImg),
                child: Container(
                  height: 140.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: new DecorationImage(
                      image: profileImg,
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(width: 0.5, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 90.0, left: 100.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _showImageOptionDialog();
                    },
                    child: new CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20.0,
                      child: new Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  void _showImageOptionDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text(
          'Choose method',
          style: AppTextStyles.normalBlack(bold, black),
          overflow: TextOverflow.ellipsis,
        ),
        children: <Widget>[
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20.0,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              title: Text(
                'Remove Profile Picture',
                style: AppTextStyles.normalBlack(normal, black),
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.pop(context);
                path = null;
              }),
          new Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(
                Icons.photo_library,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text(
              'From Gallery',
              style: AppTextStyles.normalBlack(normal, black),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.pop(context);
              _getImageFromGallery();
            },
          ),
          new Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text(
              'Take A Picture',
              style: AppTextStyles.normalBlack(normal, black),
            ),
            onTap: () {
              Navigator.pop(context);
              _getImageByCamera();
            },
          ),
        ],
      ),
    );
  }

  void _getImageFromGallery() async {
    List<Media> res = await ImagesPicker.pick(
      count: 1,
      // pickType: PickType.video,
      cropOpt: CropOption(
          // aspectRatio: CropAspectRatio.wh16x9
          ),
    );
    if (res != null) {
      print(res.map((e) => e.path).toList());
      setState(() {
        path = res[0]?.thumbPath;
        //_editUserProfile = false; //Set page to be edittable
      });
      bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
      print(status);
    }
  }

  void _getImageByCamera() async {
    List<Media> res = await ImagesPicker.openCamera(
      pickType: PickType.image,
    );
    if (res != null) {
      print(res[0]?.path);
      setState(() {
        path = res[0]?.path;
        //_editUserProfile = false; //Set page to be edittable
      });
    }
  }
}
