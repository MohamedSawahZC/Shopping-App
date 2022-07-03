class FavoritesModel
{
  bool? status;
  String? message;
  FavoritesData? data;

  FavoritesModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = FavoritesData.fromJson(json['data']);
  }
}

class FavoritesData
{
  List<DataProducts?> favourites =[];
  FavoritesData.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      favourites.add(DataProducts.fromJson(element));
    });
  }
}

class DataProducts
{
  int? id;
  ProductsModel? product;

  DataProducts.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    product = ProductsModel.fromJson(json['product']);
  }
}


class ProductsModel
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ?image;
  String ?name;
  String ?description;
  bool? inFavorites;
  bool ?inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description=json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}