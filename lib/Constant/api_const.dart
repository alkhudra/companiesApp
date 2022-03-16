abstract class ApiConst {
  static const String basic_url =
      'http://alkhudrahproject-001-site2.ctempurl.com/api';
  static const String dashboard_url = 'http://alkhadraunited.com';
  static const String pdf_url =
      'http://alkhudrahproject-001-site2.ctempurl.com';
  static const String payment_token =
      'eQWtcL16Qg90Be4BVBv4__A8ePMOZKeDj3dILlmQj-5K2SCrXdpx9TwzQcbSzzi_VG8TR08edI_eXtQVCCnRHojxKHBQy4rVZ7XlTNCCC9Q6wPWj_pyNnQwRBCAQOhJqbjPi61J6RI7lZvxsblcSmajlG6lhaDKLPiSjbdyugjrKlrb1fjntRt--vTGdnjNmiDM7LaYCR56Am6GEwTHNzNgs3M6aK2RflI2sHe0REASJ7Bb5KL0si0ku-VKjDEEqCXCqg_2ECOyHJ00hdbEEX6W7shUMNMvlZQVvbnKU4dH-OhabUyRUSkzg_3UpQiWNQX9dYNM-SY9g9iruTuyUp9-fKTLxfkQrrpO1GFSVf_vzFvAggNDCd1LJ_bdEbEPoDIasQ00ZoFKHHsEOYamtq2hLDGS5KcgShKjyMnQ3MTxKEtzxZ7j2Lso_MmyHt0NExOnro0smGpL9R3GZnk8LCSfIY4-S81JT3oxfO_D5C8GCmWugCORGkidylUB0V4VUilY74hLn_n_w0ggp0xwi8y1JrXkFf9fwKW1SLk_i3fchIX4O4LDKVwdWk43cS29Nrx_VJjDPMJlINEP4kA5sYPfiZ2Q5akIdBWLjkSIbxYXfGLsJGd-_eZGbEcN3-YQZn1C16lCB1Gqbk4nX4LkpHyF_eA6RF9GGIr-D9uZY3J-tmPqRzjUH8k4hNXfQR9Gt-1dyxg';

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
  static const String delete_product_from_fav_url =
      "/Favourites/deleteFromFavourite/{productId}";

//---------------cart ----------------
  static const String get_cart_products_url = "/Cart/getCartItems";
  static const String add_product_to_cart_url = "/Cart/addToCart";
  static const String add_product_qty_to_cart_url =
      "/Cart/AddQuantityToProduct";
  static const String delete_product_qty_from_cart_url =
      "/Cart/deleteQuantityFromProduct";
  static const String delete_product_from_cart_url =
      "/Cart/deleteFromCart/{productId}";

//--------------- checkout ----------------
//--------------- orders ----------------

  static const String get_orders = "/Order/getOrders";
  static const String submit_order = "/Order/submitOrder";
}
