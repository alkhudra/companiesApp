import 'package:khudrah_companies/network/models/branches/branch_model.dart';


class BranchListResponseModel {
  BranchListResponseModel({
      required List<BranchModel> branches,
      List<Cities>? cities,}){
    _branches = branches;
    _cities = cities;
}

  @override
  String toString() {
    return 'BranchListResponseModel{_branches: $_branches, _cities: $_cities}';
  }

  BranchListResponseModel.fromJson(dynamic json) {
    if (json['branchDtos'] != null) {
      _branches = [];
      json['branchDtos'].forEach((v) {
        _branches.add(BranchModel.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<BranchModel> _branches=[];
  List<Cities>? _cities;

  List<BranchModel>? get branches => _branches;
  List<Cities>? get cities => _cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_branches != null) {
      map['branchDtos'] = _branches.map((v) => v.toJson()).toList();
    }
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// arCityName : "دمام"
/// enCityName : "Dammam"

class Cities {
  Cities({
      String? arCityName, 
      String? enCityName,}){
    _arCityName = arCityName;
    _enCityName = enCityName;
}

  Cities.fromJson(dynamic json) {
    _arCityName = json['arCityName'];
    _enCityName = json['enCityName'];
  }
  String? _arCityName;
  String? _enCityName;

  String? get arCityName => _arCityName;
  String? get enCityName => _enCityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arCityName'] = _arCityName;
    map['enCityName'] = _enCityName;
    return map;
  }

}

