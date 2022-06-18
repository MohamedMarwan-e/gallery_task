import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_task/data/models/db/db_helper.dart';
import 'package:gallery_task/view/widgets/full_screen_image_widget.dart';


class ImageDetailScreen extends StatelessWidget {
  final String? image;
  final int? id;
   ImageDetailScreen({Key? key,required this.image,required this.id}) : super(key: key);
  var helper = DbHelper();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: image != null ?
      FullScreenImage(image:image!,id: id,) : const SizedBox(),
    );
  }




}
