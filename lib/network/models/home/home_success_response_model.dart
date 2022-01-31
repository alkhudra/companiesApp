import 'package:khudrah_companies/network/models/user_model.dart';class HomeSuccessResponseModel {
  HomeSuccessResponseModel({
    User? user,
    List<CategoryItem>? categoriesList,
    List<ProductsModel>? productsList,
  }) {
    _user = user;
    _categoriesList = categoriesList;
    _productsList = productsList;
  }


  HomeSuccessResponseModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['categoriesList'] != null) {
      _categoriesList = [];
      json['categoriesList'].forEach((v) {
        _categoriesList?.add(CategoryItem.fromJson(v));
      });
    }
    if (json['productsList'] != null) {
      _productsList = [];
      json['productsList'].forEach((v) {
        _productsList?.add(ProductsModel.fromJson(v));
      });
    }
  }
  User? _user;
  List<CategoryItem>? _categoriesList;
  List<ProductsModel>? _productsList;

  User? get user => _user;
  List<CategoryItem>? get categoriesList => _categoriesList;
  List<ProductsModel>? get productsList => _productsList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_categoriesList != null) {
      map['categoriesList'] = _categoriesList?.map((v) => v.toJson()).toList();
    }
    if (_productsList != null) {
      map['productsList'] = _productsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductsModel {
  ProductsModel({
    String? productId,
    String? name,
    String? arName,
    bool? hasSpecialPrice,
    num? originalPrice,
    num? specialPrice,
    num? quantity,
    String? description,
    String? arDescription,
    bool? isAvailabe,
    bool? isActive,
    String? image,
    String? categoryId,
  }) {
    _productId = productId;
    _name = name;
    _arName = arName;
    _hasSpecialPrice = hasSpecialPrice;
    _originalPrice = originalPrice;
    _specialPrice = specialPrice;
    _quantity = quantity;
    _description = description;
    _arDescription = arDescription;
    _isAvailabe = isAvailabe;
    _isActive = isActive;
    _image = image;
    _categoryId = categoryId;
  }

  ProductsModel.fromJson(dynamic json) {
    _productId = json['productId'];
    _name = json['name'];
    _arName = json['arName'];
    _hasSpecialPrice = json['hasSpecialPrice'];
    _originalPrice = json['originalPrice'];
    _specialPrice = json['specialPrice'];
    _quantity = json['quantity'];
    _description = json['description'];
    _arDescription = json['arDescription'];
    _isAvailabe = json['isAvailabe'];
    _isActive = json['isActive'];
    _image = json['image'];
    _categoryId = json['categoryId'];
  }
  String? _productId;
  String? _name;
  String? _arName;
  bool? _hasSpecialPrice;
  num? _originalPrice;
  num? _specialPrice;
  num? _quantity;
  String? _description;
  String? _arDescription;
  bool? _isAvailabe;
  bool? _isActive;
  String? _image;
  String? _categoryId;

  String? get productId => _productId;
  String? get name => _name;
  String? get arName => _arName;
  bool? get hasSpecialPrice => _hasSpecialPrice;
  num? get originalPrice => _originalPrice;
  num? get specialPrice => _specialPrice;
  num? get quantity => _quantity;
  String? get description => _description;
  String? get arDescription => _arDescription;
  bool? get isAvailabe => _isAvailabe;
  bool? get isActive => _isActive;
  String? get image => _image;
  String? get categoryId => _categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['name'] = _name;
    map['arName'] = _arName;
    map['hasSpecialPrice'] = _hasSpecialPrice;
    map['originalPrice'] = _originalPrice;
    map['specialPrice'] = _specialPrice;
    map['quantity'] = _quantity;
    map['description'] = _description;
    map['arDescription'] = _arDescription;
    map['isAvailabe'] = _isAvailabe;
    map['isActive'] = _isActive;
    map['image'] = _image;
    map['categoryId'] = _categoryId;
    return map;
  }
}

/// id : "dsjah894"
/// name : "Fruit"
/// arName : "فواكه"
/// isActive : true
/// image : "/categoryImages/44ab9c9e-dac4-468b-b708-f6571d793b96.jpg"

class CategoryItem {
  CategoryItem({
    String? id,
    String? name,
    String? arName,
    bool? isActive,
    String? image,
  }) {
    _id = id;
    _name = name;
    _arName = arName;
    _isActive = isActive;
    _image = image;
  }

  CategoryItem.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _arName = json['arName'];
    _isActive = json['isActive'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _arName;
  bool? _isActive;
  String? _image;

  String? get id => _id;
  String? get name => _name;
  String? get arName => _arName;
  bool? get isActive => _isActive;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['arName'] = _arName;
    map['isActive'] = _isActive;
    map['image'] = _image;
    return map;
  }
}
