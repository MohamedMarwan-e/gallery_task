import 'package:flutter/cupertino.dart';
import 'package:gallery_task/data/models/search_model.dart';
import 'package:gallery_task/services/components/remote/dio_helper.dart';
import 'package:gallery_task/services/components/remote/url.dart';

class SearchProvider extends ChangeNotifier{
  SearchModel? searchModel;

  Future<SearchModel?> getSearch({required String query,  int? perPage,  int? page}) async{
    try{
      await DioHelper.getData(
          url: "search",
        query: {
          "query": query,
          "per_page": perPage,
          "page": page,
        },
        apiKey: Url.apiKey,
        ).then((value) {
          print(value.data);
          searchModel = SearchModel.fromJson(value.data);
        });
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
    return searchModel;

  }
}