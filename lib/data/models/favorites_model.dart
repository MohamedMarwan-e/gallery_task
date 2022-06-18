class Favorites {
  int? favoritesId;
  String? favoritesImage;


  Favorites({this.favoritesId, this.favoritesImage,});


  Map<String, dynamic> toMap() {
    return {'favoritesId': favoritesId, 'favoritesImage': favoritesImage, };
  }

  Favorites.fromMap(Map<String, dynamic> map){
    favoritesId = map['favoritesId'];
    favoritesImage = map['favoritesImage'];

  }
}
