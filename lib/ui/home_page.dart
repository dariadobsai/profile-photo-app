import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_app/bloc/photo_bloc.dart';
import 'package:photo_app/ui/edit_page.dart';

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
                child: BlocBuilder<PhotoBloc, PhotoState>(
                  cubit: BlocProvider.of<PhotoBloc>(
                      context), // provide the local bloc instance
                  builder: (context, state) {
                    return Container(
                      height: 150,
                      width: 150,
                      child: state is PhotoInitial
                          ? Image.asset('assets/images/user.png')
                          : Image.file((state as PhotoSet).photo),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
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

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPhotoPage(image: _image),
          ),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPhotoPage(image: _image),
          ),
        );
      } else {
        print('No image selected.');
      }
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
              getImageFromGallery();
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: Text('Take a photo'),
            onPressed: () {
              getImageFromCamera();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
