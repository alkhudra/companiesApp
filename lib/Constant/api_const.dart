abstract class ApiConst {
  static const String basic_url =
      'http://alkhudrahproject-001-site2.ctempurl.com/api';

  //---------------auth ----------------
  static const String register_url = '/account/register';
  static const String login_url = '/account/login';
  static const String get_user_info_url = '/account/getRegisteredUser';
  static const String update_profile_url = '/account/updateUser';
  static const String reset_password_url = '/account/resetPassword';
  static const String forget_password_url = '/account/forgetPassword';
  static const String send_code_url = '/account/sendCode';
  static const String check_password_token_url = '/account/checkPasswordToken';


  //---------------branch ----------------

  static const String add_branch_url =  "/branch/addBranch";
  static const String delete_branch_url =  "/branch/deleteBranch";
  static const String get_branch_url =  "/branch/getAllBranches";
  static const String update_branch_url =  "/branch/updateBranch";


}
