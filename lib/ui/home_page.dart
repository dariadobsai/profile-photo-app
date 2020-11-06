import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_app/route/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _showSelectionDialog();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  child: _image == null
                      ? Image.asset('assets/images/user.png')
                      : Image.file(_image),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Please select your profile photo',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pushNamed(context, routeEdit, arguments: _image);
      } else
        print('No photo was selected or taken');
    });
  }

  Future _showSelectionDialog() async {
    await showDialog(
      context: context,
      child: SimpleDialog(
        title: Text('Select photo'),
        children: <Widget>[
          SimpleDialogOption(
            child: Text('From gallery'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Take a photo'),
            onPressed: () {
              selectOrTakePhoto(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
