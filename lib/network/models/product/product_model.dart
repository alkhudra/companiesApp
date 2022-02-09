class ProductsModel {
  ProductsModel({
    String? productId,
    String? name,
    String? arName,
    String? categoryName,
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
    String? arCategoryName,
    String? categoryId,
  }) {
    _productId = productId;
    _name = name;
    _arCategoryName = arCategoryName;
    _categoryName = categoryName;
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
    _quantity = json['stockQuantity'];
    _description = json['description'];
    _arDescription = json['arDescription'];
    _isAvailabe = json['isAvailabe'];
    _isActive = json['isActive'];
    _image = json['image'];
    _categoryName = json['categoryName'];
    _isFavourite = json['isFavourite'];
    _categoryId = json['categoryId'];
    _arCategoryName = json['arCategoryName'];
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
  String? _categoryName;
  String? _arCategoryName;
  static int _userSelectedQty = 1;
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
  String? get arCategoryName => _arCategoryName;
  String? get categoryName => _categoryName;
  int get userSelectedQty => _userSelectedQty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['name'] = _name;
    map['arName'] = _arName;
    map['arCategoryName'] = _arCategoryName;
    map['categoryName'] = _categoryName;
    map['hasSpecialPrice'] = _hasSpecialPrice;
    map['originalPrice'] = _originalPrice;
    map['specialPrice'] = _specialPrice;
    map['stockQuantity'] = _quantity;
    map['description'] = _description;
    map['arDescription'] = _arDescription;
    map['isAvailabe'] = _isAvailabe;
    map['isActive'] = _isActive;
    map['image'] = _image;
    map['isFavourite'] = _isFavourite;
    map['categoryId'] = _categoryId;
    return map;
  }

  static void increaseQty() {
    _userSelectedQty++;
    print(_userSelectedQty);
  }

 static void decreaseQty() {
    _userSelectedQty > 1 ? _userSelectedQty -- : _userSelectedQty = 1;
    print(_userSelectedQty);
  }

  @override
  String toString() {
    return 'ProductsModel{_productId: $_productId, _name: $_name, _arName: $_arName, _hasSpecialPrice: $_hasSpecialPrice, _originalPrice: $_originalPrice, _specialPrice: $_specialPrice, _quantity: $_quantity, _description: $_description, _arDescription: $_arDescription, _isAvailabe: $_isAvailabe, _isActive: $_isActive, _image: $_image, _categoryId: $_categoryId, _isFavourite: $_isFavourite, _categoryName: $_categoryName, _arCategoryName: $_arCategoryName}';
  }
}
