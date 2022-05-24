class ProductsModel {
  ProductsModel({
    String? productId,
    String? name,
    String? arName,
    String? categoryName,
    String? arCategoryName,
    bool? hasSpecialPrice,
    int? originalPrice,
    int? specialPrice,
    bool? isFavourite,
    int? stockQuantity,
    String? description,
    String? arDescription,
    bool? isAvailabe,
    bool? isActive,
    bool? isDeleted,
    String? image,
    String? categoryId,
    String? productUnitId,
    String? unitCode,
    String? arItemUnitDesc,
    String? enItemUnitDesc,
    int? userProductQuantity,
    bool? isAddedToCart,
    num? netPrice,
    num? vaT15OriginalValue,
    num? netSpecialPrice,
    num? vaT15SpecialPrice,
  }) {
    _productId = productId;
    _name = name;
    _arName = arName;
    _categoryName = categoryName;
    _arCategoryName = arCategoryName;
    _hasSpecialPrice = hasSpecialPrice;
    _originalPrice = originalPrice;
    _netPrice = netPrice;
    _vaT15OriginalValue = vaT15OriginalValue;
    _netSpecialPrice = netSpecialPrice;
    _vaT15SpecialPrice = vaT15SpecialPrice;
    _specialPrice = specialPrice;
    _isFavourite = isFavourite;
    _quantity = stockQuantity;
    _description = description;
    _arDescription = arDescription;
    _isAvailabe = isAvailabe;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _image = image;
    _categoryId = categoryId;
    _productUnitId = productUnitId;
    _unitCode = unitCode;
    _arItemUnitDesc = arItemUnitDesc;
    _enItemUnitDesc = enItemUnitDesc;
    _userProductQuantity = userProductQuantity;
    _isAddedToCart = isAddedToCart;
  }

  ProductsModel.fromJson(dynamic json) {
    _productId = json['productId'];
    _name = json['name'];
    _arName = json['arName'];
    _categoryName = json['categoryName'];
    _arCategoryName = json['arCategoryName'];
    _hasSpecialPrice = json['hasSpecialPrice'];
    _originalPrice = json['originalPrice'];
    _specialPrice = json['originalSpecialPrice'];
    _isFavourite = json['isFavourite'];
    _quantity = json['stockQuantity'];
    _description = json['description'];
    _arDescription = json['arDescription'];
    _isAvailabe = json['isAvailabe'];
    _isActive = json['isActive'];
    _isDeleted = json['isDeleted'];
    _image = json['image'];
    _categoryId = json['categoryId'];
    _productUnitId = json['productUnitId'];
    _unitCode = json['unitCode'];
    _arItemUnitDesc = json['arItemUnitDesc'];
    _enItemUnitDesc = json['enItemUnitDesc'];
    _userProductQuantity = json['userProductQuantity'];
    _isAddedToCart = json['isAddedToCart'];
    _netPrice = json['netPrice'];
    _vaT15OriginalValue = json['vaT15'];
    _netSpecialPrice = json['netSpecialPrice'];
    _vaT15SpecialPrice = json['vaT15SpecialPrice'];
  }
  String? _productId;
  String? _name;
  String? _arName;
  String? _categoryName;
  String? _arCategoryName;
  bool? _hasSpecialPrice;
  num? _originalPrice;
  num? _netPrice;
  num? _vaT15OriginalValue;
  num? _netSpecialPrice;
  num? _vaT15SpecialPrice;

  num? _specialPrice;
  bool? _isFavourite;
  int? _quantity;
  String? _description;
  String? _arDescription;
  bool? _isAvailabe;
  bool? _isActive;
  bool? _isDeleted;
  String? _image;
  String? _categoryId;
  String? _productUnitId;
  String? _unitCode;
  String? _arItemUnitDesc;
  String? _enItemUnitDesc;
  int? _userProductQuantity;
  bool? _isAddedToCart;

  String? get productId => _productId;
  String? get name => _name;
  String? get arName => _arName;
  String? get categoryName => _categoryName;
  String? get arCategoryName => _arCategoryName;
  bool? get hasSpecialPrice => _hasSpecialPrice;
  num? get originalPrice => _originalPrice;
  num? get specialPrice => _specialPrice;
  bool? get isFavourite => _isFavourite;
  int? get quantity => _quantity;
  String? get description => _description;
  String? get arDescription => _arDescription;
  bool? get isAvailabe => _isAvailabe;
  bool? get isActive => _isActive;
  bool? get isDeleted => _isDeleted;
  String? get image => _image;
  String? get categoryId => _categoryId;
  String? get productUnitId => _productUnitId;
  String? get unitCode => _unitCode;
  String? get arItemUnitDesc => _arItemUnitDesc;
  String? get enItemUnitDesc => _enItemUnitDesc;
  int? get userProductQuantity => _userProductQuantity;
  bool? get isAddedToCart => _isAddedToCart;

  num? get netPrice => _netPrice;
  num? get vaT15OriginalValue => _vaT15OriginalValue;
  num? get netSpecialPrice => _netSpecialPrice;
  num? get vaT15SpecialPrice => _vaT15SpecialPrice;


  set userProductQuantity(int? value) {
    _userProductQuantity = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['name'] = _name;
    map['arName'] = _arName;
    map['categoryName'] = _categoryName;
    map['arCategoryName'] = _arCategoryName;
    map['hasSpecialPrice'] = _hasSpecialPrice;
    map['originalPrice'] = _originalPrice;
    map['originalSpecialPrice'] = _specialPrice;
    map['isFavourite'] = _isFavourite;
    map['stockQuantity'] = _quantity;
    map['description'] = _description;
    map['arDescription'] = _arDescription;
    map['isAvailabe'] = _isAvailabe;
    map['isActive'] = _isActive;
    map['isDeleted'] = _isDeleted;
    map['image'] = _image;
    map['categoryId'] = _categoryId;
    map['productUnitId'] = _productUnitId;
    map['unitCode'] = _unitCode;
    map['arItemUnitDesc'] = _arItemUnitDesc;
    map['enItemUnitDesc'] = _enItemUnitDesc;
    map['userProductQuantity'] = _userProductQuantity;
    map['isAddedToCart'] = _isAddedToCart;
    map['netPrice'] = _netPrice;
    map['vaT15'] = _vaT15OriginalValue;
    map['netSpecialPrice'] = _netSpecialPrice;
    map['vaT15SpecialPrice'] = _vaT15SpecialPrice;

    return map;
  }

  @override
  String toString() {
    return 'ProductsModel{_arName: $_arName}';
  }
}
