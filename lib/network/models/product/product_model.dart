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
    bool? isFavourite,
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
    _isFavourite = isFavourite;
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
    _isFavourite = json['isFavourite'];
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
  bool? _isFavourite;

  bool? get isFavourite => _isFavourite;

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
    map['isFavourite'] = _isFavourite;
    map['categoryId'] = _categoryId;
    return map;
  }
}
