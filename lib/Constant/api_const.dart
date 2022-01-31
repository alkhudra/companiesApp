abstract class ApiConst {
  static const String basic_url =
      'http://alkhudrahproject-001-site2.ctempurl.com/api';
  static const String images_url =
      'http://alkhadraunited.com';

  //---------------auth ----------------
  static const String register_url = '/account/register';
  static const String login_url = '/account/login';
  static const String get_user_info_url = '/account/getRegisteredUser/{id}';
  static const String update_profile_url = '/account/updateUser/{id}';
  static const String reset_password_url = '/account/resetPassword';
  static const String forget_password_url = '/account/forgetPassword';
  static const String send_code_url = '/account/sendCode';
  static const String check_password_token_url = '/account/checkPasswordToken';

  //---------------branch ----------------

  static const String add_branch_url = "/branch/addBranch/{id}";
  static const String delete_branch_url = "/branch/deleteBranch/{id}";
  static const String get_branch_url = "/branch/getAllBranches/{id}";
  static const String update_branch_url = "/branch/updateBranch/{id}";
//---------------home ----------------
  static const String get_home_url = "/Home/getProductsCategories";
  static const String get_contact_url = "/Home/getContactUs";

  //---------------products ----------------

  static const String get_products_url = "/Home/getProducts";
  static const String get_products_by_category_url =
      "/Home/getProductByCategoryId/categoryId";
  static const String get_products_by_id_url = "/Home/getProductById/productId";
  //---------------favorite ----------------

  static const String get_favorite_products_url = "/Favourites/getFavourites";
  static const String add_product_to_fav_url =
      "/Favourites/addToFavourite/{productId}";
  static const String delete_product_from_fav_url = "/Favourites/deleteFromFavourite/{productId}";



}
