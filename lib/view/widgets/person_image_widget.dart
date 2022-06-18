// import 'package:flutter/material.dart';
// import 'package:gallery_task/controller/person_details_provider.dart';
// import 'package:gallery_task/data/models/person_images_model.dart';
// import 'package:gallery_task/view/screens/image_screen.dart';
// import 'package:gallery_task/view/widgets/custom_image.dart';
// import 'package:provider/provider.dart';
//
// class PersonImageWidget extends StatelessWidget{
//
//   final int id;
//   PersonImageWidget({super.key, required this.id});
//
//   PersonImagesModel? personImagesModel;
//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     final ref = Provider.of<PersonDetailsProvider>(context,listen: false);
//
//     return FutureBuilder<PersonImagesModel?>(
//         future: ref.getPersonImages(id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//             personImagesModel =snapshot.data;
//             return ref.personImagesModel!.profiles!.length == 1 ?
//             const SizedBox.shrink():
//             Wrap(
//               direction: Axis.horizontal,
//               children:List.generate(ref.personImagesModel!.profiles!.length , (index) {
//                 return InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDetailScreen(image: "http://image.tmdb.org/t/p/w500${ref.personImagesModel!.profiles![index].filePath}")));
//                   },
//                   child: CustomImage(
//                     "http://image.tmdb.org/t/p/w500${ref.personImagesModel!.profiles![index].filePath}",
//                     width: media.width * 0.44,
//                     height: 200,
//                     horizontal: media.width * 0.029,
//                     radius: 10,
//                     isShadow: true,
//                   ),
//                 );
//               }
//               ),
//             );
//           }
//           return const SizedBox();
//         }
//     );
//   }
//
// }