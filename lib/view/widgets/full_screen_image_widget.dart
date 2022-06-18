import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gallery_task/controller/favorites_provider.dart';
import 'package:gallery_task/core/helper/colors.dart';
import 'package:gallery_task/data/models/favorites_model.dart';
import 'package:gallery_task/view/widgets/custom_image.dart';
import 'package:gallery_task/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class FullScreenImage extends StatelessWidget{
  final String? image;
  final int? id;
  FullScreenImage({Key? key,required this.image,required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<FavoriteProvider>(context);

    return SafeArea(
        child: Stack(
          children: [
            CustomImage(
              image!,
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              horizontal: 0,
              vertical: 0,
              borderRadius: BorderRadius.circular(0),
              radius: 10,
            ),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: MyColors.primary
                    )
                )
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await GallerySaver.saveImage(image!);
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                              content: CustomText(text: "Downloaded to Gallery!",)
                          )
                          );
                        },
                        icon: Icon(
                            Icons.save_alt,
                            color: MyColors.primary
                        )
                    ),
                    IconButton(
                        onPressed: () async {
                          Favorites favorites = Favorites(
                            favoritesId: id,
                            favoritesImage: image,
                          );

                          ref.addFav(favorites, context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: CustomText(text: "Added to Favorites!",)
                          )
                          );
                        },
                        icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.red
                        )
                    ),
                  ],
                )
            ),
          ],
        ),
      );
    }
  }

