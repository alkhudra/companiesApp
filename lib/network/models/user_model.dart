import 'branches/branch_model.dart';

class User {
  User({
    required String id,
    String? email,
    String? phoneNumber,
    String? ownerName,
    String? companyName,
    String? companyStatus,
    String? commercialRegistrationNo,
    String? vatNo,
    bool? hasCreditOption,
    num? companyBalance,
    int? branchNumber,
    bool? isDeleted,
    List<BranchModel>? branches,
  }) {
    _id = id;
    _email = email;
    _companyStatus = companyStatus;
    _hasCreditOption = hasCreditOption;
    _phoneNumber = phoneNumber;
    _ownerName = ownerName;
    _companyBalance = companyBalance;
    _companyName = companyName;
    _commercialRegistrationNo = commercialRegistrationNo;
    _vatNo = vatNo;
    _isDeleted = isDeleted;
    _branchNumber = branchNumber;
    _branches = branches;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _companyBalance = json['companyBalance'];
    _phoneNumber = json['phoneNumber'];
    _ownerName = json['ownerName'];
    _companyName = json['companyName'];
    _commercialRegistrationNo = json['commercialRegistrationNo'];
    _vatNo = json['vatNo'];
    _companyStatus = json['companyStatus'];
    _hasCreditOption = json['hasCreditOption'];
    _branchNumber = json['branchNumber'];
    _isDeleted= json['isDeleted'];
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(BranchModel.fromJson(v));
      });
    }
  }
  String _id = '';
  String? _email;
  String? _phoneNumber;
  String? _ownerName;
  String? _companyName;
  String? _commercialRegistrationNo;
  String? _vatNo;
  String? _companyStatus;
  num? _companyBalance;
  int? _branchNumber;
  bool? _isDeleted;
  List<BranchModel>? _branches;
  bool? _hasCreditOption;
  String? get id => _id;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get ownerName => _ownerName;
  String? get companyName => _companyName;
  String? get commercialRegistrationNo => _commercialRegistrationNo;
  int? get branchNumber => _branchNumber;
  List<BranchModel>? get branches => _branches;
  String? get companyStatus => _companyStatus;

  bool? get hasCreditOption => _hasCreditOption;
  num? get companyBalance => _companyBalance;
  String? get vatNo => _vatNo;

  bool? get isDeleted => _isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['companyBalance'] = _companyBalance;
    map['phoneNumber'] = _phoneNumber;
    map['ownerName'] = _ownerName;
    map['companyName'] = _companyName;
    map['commercialRegistrationNo'] = _commercialRegistrationNo;
    map['vatNo'] = _vatNo;
    map['hasCreditOption'] = _hasCreditOption;
    map['branchNumber'] = _branchNumber;
    map['companyStatus'] = _companyStatus;
    map['isDeleted']  = _isDeleted;
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'User{_id: $_id, _email: $_email, _phoneNumber: $_phoneNumber, _ownerName: $_ownerName, _companyName: $_companyName, _commercialRegistrationNo: $_commercialRegistrationNo, _vatNo: $_vatNo, _companyBalance: $_companyBalance, _branchNumber: $_branchNumber, _branches: $_branches, _hasCreditOption: $_hasCreditOption}';
  }
}
