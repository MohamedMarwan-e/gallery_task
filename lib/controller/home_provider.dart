import 'package:flutter/cupertino.dart';
import 'package:gallery_task/data/models/image_model.dart';
import 'package:gallery_task/services/components/remote/dio_helper.dart';
import 'package:gallery_task/services/components/remote/url.dart';



class HomeProvider extends ChangeNotifier{
  ImagesModel? imagesModel;

  Future<ImagesModel?> popularMovie(int page,int perPage) async {
    try{
      await DioHelper.getData(
          url: "curated",
          query: {
            "page": page,
            "per_page": perPage,
          },
          apiKey: Url.apiKey,

      ).then((value) {
         print(value.data);
        imagesModel =  ImagesModel.fromJson(value.data);
      });
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
    return imagesModel ;
  }

}