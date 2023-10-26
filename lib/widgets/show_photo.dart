import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/massages_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhoto extends StatelessWidget {
  static String id = 'ShowPhoto';
  const ShowPhoto({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: PhotoView(
        imageProvider: NetworkImage(url.toString()),
      )),
    );
  }
}
