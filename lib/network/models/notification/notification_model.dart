/// id : "0878aae4-5b7f-4a50-b16c-fd561919733e"
/// userId : "d2fa0b28-905e-4477-bcaa-159eacbdb71b"
/// title : "This is only for testing purpose"
/// body : "You are in the GetProductsCategories for test"
/// sentDateTime : "2022-03-31 15:15"
/// isSeccuss : false

class NotificationModel {
  NotificationModel({
      String? id, 
      String? userId, 
      String? title, 
      String? body, 
      String? sentDateTime, 
      bool? isSeccuss,}){
    _id = id;
    _userId = userId;
    _title = title;
    _body = body;
    _sentDateTime = sentDateTime;
    _isSeccuss = isSeccuss;
}

  NotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _title = json['title'];
    _body = json['body'];
    _sentDateTime = json['sentDateTime'];
    _isSeccuss = json['isSeccuss'];
  }
  String? _id;
  String? _userId;
  String? _title;
  String? _body;
  String? _sentDateTime;
  bool? _isSeccuss;

  String? get id => _id;
  String? get userId => _userId;
  String? get title => _title;
  String? get body => _body;
  String? get sentDateTime => _sentDateTime;
  bool? get isSeccuss => _isSeccuss;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['title'] = _title;
    map['body'] = _body;
    map['sentDateTime'] = _sentDateTime;
    map['isSeccuss'] = _isSeccuss;
    return map;
  }

}