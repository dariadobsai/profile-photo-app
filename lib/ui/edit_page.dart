import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_app/bloc/photo_bloc.dart';

class EditPhotoPage extends StatefulWidget {
  final File image;

  const EditPhotoPage({@required this.image});

  @override
  _EditPhotoPageState createState() => _EditPhotoPageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditPhotoPageState extends State<EditPhotoPage> {
  AppState state;
  File imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.picked;
    imageFile = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: widget.image != null ? Image.file(widget.image) : Container(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* if (state == AppState.free) {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          } else */
          if (state == AppState.picked) _cropImage();
          /*else if (state == AppState.cropped) {
            // TODO: pop until with data https://medium.com/@hungregistermail/flutter-popuntil-with-return-data-ece825aedbd0
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          }*/
        },
      ),
    );
  }

  /*void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }*/

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      submitPhoto(imageFile);
      Navigator.pop(context);
      /*setState(() {
        state = AppState.cropped;
      });*/
    }
  }

  submitPhoto(File editedPhoto) {
    final photoBloc = BlocProvider.of<PhotoBloc>(context);
    photoBloc.add(GetPhoto(editedPhoto));
  }
}
