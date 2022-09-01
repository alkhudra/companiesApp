abstract class ApiConst {
  static const String basic_url =
   'https://alkhadraunited.com/api';
 // 'http://alkhudrahproject-001-site2.ctempurl.com/api';
  static const String dashboard_url ='https://dashboard.alkhadraunited.com';//'https://alkhadraunited.com/';//'http://alkhudrahproject-001-site1.ctempurl.com/' ;
  static const String pdf_url =  'https://dashboard.alkhadraunited.com';
     // 'http://alkhudrahproject-001-site2.ctempurl.com';
  static const String payment_token =
      'VvXSKNFpsHFprBUzg6T4ZJK7ZjEkSMydS3v9e_Ro12ZQPQRUow45N2m-Xq-41MvSAo6BLx36tYZ6Xuk_c_AtAOsn0ZWAAgrKcytoFMuohaHA7hS2BOOdMyHqAEmNW5C11RPF7l_juOVmqYG7nqW3dwfj6uuNhNG_bi6-1FHDHePWm9BJIljxjqJTDG_ceFArToseu9UXwD-IGSfmHAtkg2Jeo7N6j5_wbTrxdB9OdN7OjU4lXquJgBZKfBfB3ubiZqyB39_PYIJ1w8iDJ9rdSCEdaLfWdV81kfF9RHKsb2v9yNFKfLy2lv4woYfKDEYpSBqqrJf4IZ4rPs9dK9h_n_cXAsZ_OtYeXCL3zorSrscgegr20WqcGHfb8GpKfDxRG08wl66lzT0yFi8I-H-7YNyTM5Xb6Q1neY1wCvZYo2mm50TwYBEi3g-OtvA7x7hBSm3J2ZCotN-yZY3ZrSmdoIzakG-wcfUIKGbzvYQTgtWOhygaLgGd5U_j9V56CR58xauKEEza2VgHI-7amKacAFc_OjvN9HXrxu_3b9TWiEMKpgkuy-eOB5Wks1Ye1yGQGsO1V0jK76nQvPVPEomypZuNIMFK6IpTS5I-p6ZVRgENC1qHzoePG3Cw5Ub9m4n_09xy1YwITHSKny8lcAOWJzJjmDFqsQPkvFWr4YaH13oAKS3CR0TTz306eVNYdUyK9Va0yg';

  //---------------auth ----------------
  static const String register_url = '/account/register';
  static const String login_url = '/account/login';
  static const String logout_url = '/account/logout';
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

//--------------- orders ----------------

  static const String get_orders = "/Order/getOrders";
  static const String get_order_by_id = "/Order/getOrderById/{id}";

  static const String submit_order = "/Order/submitOrder";
//--------------- orders ----------------
  static const String get_notification = "/Notification/getUserNotifications";
}
