import 'package:flutter/material.dart';
import 'package:gallery_task/data/models/db/db_helper.dart';
import 'package:gallery_task/data/models/favorites_model.dart';




class FavoriteProvider extends ChangeNotifier{

  // bool _isfav = false;
  // bool get isfav => _isfav;
  //
  // void onchangeIcon(){
  //   _isfav=!_isfav;
  //   notifyListeners();
  // }

  List<Favorites> favoritesList = [];

  List get FavoritesList => favoritesList;

  var helper = DbHelper();

  void addFav(Favorites favorites,BuildContext context) async {
    int? row = await helper.saveFavorites(favorites);
    if (row != 0) {
      print("done");
    }
    notifyListeners();
  }

  Future<List<Favorites>?> viewAllFavorites() async{
    helper.viewFavorites().then((map){
      favoritesList = map ;
    }
    );
    notifyListeners();

  }

  void deleteFav(Favorites favorites,BuildContext context) async{
    helper.deleteFavorites(favorites).then((value) {
      viewAllFavorites();
    });
    notifyListeners();
  }

}