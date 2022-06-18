import 'package:flutter/material.dart';
import 'package:gallery_task/controller/home_provider.dart';
import 'package:gallery_task/core/helper/colors.dart';
import 'package:gallery_task/data/models/image_model.dart';
import 'package:gallery_task/view/screens/image_screen.dart';
import 'package:gallery_task/view/widgets/custom_image.dart';
import 'package:gallery_task/view/widgets/custom_text.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget{
 const HomeScreen({Key? key}) : super(key: key);

 @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PagingController<int, Photo> pagingController = PagingController(firstPageKey: 1);
  final int pageSize = 1;
  bool servicesLoader = false;

  Future<void> servicesFuture({required int pageKey}) async {
    servicesLoader = true;
    try {
      var data = await Provider.of<HomeProvider>(context, listen: false).popularMovie(pageKey,6);
      if (data != null) {
        List<Photo> adds = data.photos!;
        if (pageKey == 1) {
          pagingController.itemList = [];
        }
        final isLastPage = adds.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(adds);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(adds, nextPageKey);
        }
      }
      servicesLoader = false;
    } catch (e) {
      servicesLoader = false;
      rethrow;
    }
  }

  @override
  void initState()  {
    servicesFuture(pageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      servicesFuture(pageKey: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
     final ref = Provider.of<HomeProvider>(context);

     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         elevation: 1,
         centerTitle: true,
         title: CustomText(
           text: "Home",
           color: MyColors.primary,
         ),
       ),
      body: servicesLoader || ref.imagesModel == null ?
          const Center(child: CircularProgressIndicator()) :
          SafeArea(
            child: PagedGridView<int, Photo>(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              pagingController: pagingController,
              padding: const EdgeInsets.only(bottom: 30),
              shrinkWrap: true,
              builderDelegate: PagedChildBuilderDelegate<Photo>(
                noItemsFoundIndicatorBuilder: (context) => const Text('No Item Found'),
                firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  itemBuilder: (context, item, index) => SizedBox(
                    width: media.width ,
                    child: InkWell(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ImageDetailScreen(image: item.src!.large,id: item.id,)));
                      },
                      child: CustomImage(
                        item.src!.large!,
                        horizontal: media.width * 0.02,
                        radius: 10,
                        isShadow: true,
                            ),
                         ),
                       )
                   ),
                  ),
              ),
     );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

}