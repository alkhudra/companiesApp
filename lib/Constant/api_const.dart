abstract class ApiConst {
  static const String basic_url =
      'http://alkhudrahproject-001-site2.ctempurl.com/api';
  static const String images_url =
      'http://alkhadraunited.com';

  static const String payment_token ="F96WjHY0jaqWAgvtK2bcaCahmPneBWA0ANaSp0EZNgF7T5Lw0o1PkZ4pnCAry153gBO-ggXS0HvcfR_pdcTh9JTKOsfVqK4kaRR3Or_EHZO2BRwTQj1fTulwV2LEUfzO1-Kw3DXJrqygW9gMwqX7uVrnyCWrZUxILLtaP22e7ubN5UWCU3lIBRYtDErTQ507gg-c3Zs406NdVNlZ-FWjSYAb8voL7p8eW2UpT8Fy-qGH4EaXgIR35QRhv_uX0pZJHqkoCGO7RV5mf8IJvsr3WlKRkEhEHcO5wY_kQ5OzODUEcL6vFG-SaPEeYAgqTsUDe6vWJCCflwLrGW-tqoyODye1N1Bc-cm2lB3zynJI43z321ehbUqwYw1LPXOPA7weE8cafRBQyn8FRtkqeLaWqQqVCrpGPnAfUQS1EfvLLOMeakS1lp9K4VBDueuD_laY0IoynXB8QzGiID1DSV5spvFUknJKnoeWvdTplGgW48R9qrHeapAA0rFUWMsG46xN-GiLcwqG5-hVFR3zECclct3J_2TikDoeI2HZXUF1ALov4SHJHZlfsJoxjoCv0BftO1HHoiyLsercA93iqihvYiW1Wls4CjOdhPJgHmSTHsU2FQC4w0Sqc1CQqjMhKjsOr9GAH7PeCsl02ZR63fpEh727mHsmO0fuFyEfmvnvzrmkd0aGaxSiAKZsMZuEkIBaefeQGQ";
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

//---------------cart ----------------
  static const String get_cart_products_url = "/Cart/getCartItems";
  static const String add_product_to_cart_url =
      "/Cart/addToCart";
  static const String add_product_qty_to_cart_url =
      "/Cart/AddQuantityToProduct";
  static const String delete_product_qty_from_cart_url =
      "/Cart/deleteQuantityFromProduct";
  static const String delete_product_from_cart_url =
      "/Cart/deleteFromCart/{productId}";

}
