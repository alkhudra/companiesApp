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