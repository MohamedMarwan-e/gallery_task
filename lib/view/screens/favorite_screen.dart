import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gallery_task/controller/favorites_provider.dart';
import 'package:gallery_task/core/helper/colors.dart';
import 'package:gallery_task/view/screens/image_screen.dart';
import 'package:gallery_task/view/widgets/custom_image.dart';
import 'package:gallery_task/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget{
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final ref = Provider.of<FavoriteProvider>(context,listen: true);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.viewAllFavorites();
    });


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: CustomText(
          text: "Favorite",
          color: MyColors.primary,
        ),
      ),
      body:ref.FavoritesList.isEmpty?
          const Center(
            child: CustomText(
              text: "No Favorite",
            )
          ):
      SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              children:List.generate(ref.FavoritesList.length,(index) {
                return ref.FavoritesList[index].favoritesImage == null?
                  const SizedBox.shrink():
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDetailScreen(image:ref.FavoritesList[index].favoritesImage,id: ref.FavoritesList[index].favoritesId)));
                    },
                    child: CustomImage(
                      "${ref.FavoritesList[index].favoritesImage}",
                      width: media.width * 0.44,
                      height: 200,
                      horizontal: media.width * 0.029,
                      radius: 10,
                      isShadow: true,
                    ),
                  );
              }
              ),
            ),
          ],
        ),
      )
    );
  }
}