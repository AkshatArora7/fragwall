import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';


class ImageView extends StatefulWidget {
  final String imgUrl;
  var filePath;

  ImageView({@required this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _setWallpaper();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 51.0,
                        decoration: BoxDecoration(
                          color: Color(0xff1c1b1b).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      Container(
                        height: 51.0,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white60, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xff121212)
//                        gradient: LinearGradient(colors: [
//                          const Color(0xff212529).withOpacity(0.7),
//                          const Color(0xfffced4da).withOpacity(0.9)
//                        ])
                            ),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Download ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Wallpaper",
                                    style: TextStyle(color: Color(0xffbb86fc)),
                                  )
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//  _save() async {
//    if (Platform.isAndroid) {
//      await _askPermission();
//    }
//    var response = await Dio()
//        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
//
//    final result =
//        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//    print(result);
//    Navigator.pop(context);
//  }
//
//  _askPermission() async {
//    await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
////    print("permission request result is " + res.toString());
//  }
//}

void _setWallpaper() async{
    var response = await http.get(widget.imgUrl);
    widget.filePath= await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

    _getWallpaper();
  }

  static const platform = const MethodChannel('wallpaper');
  Future<void> _getWallpaper() async {
    try {
      final int result =  await platform.invokeMethod('getWallpaper',{"text":widget.filePath});

    } on PlatformException catch (e) {
      Navigator.pop(context);

    }
  }
}
