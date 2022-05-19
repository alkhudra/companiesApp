import 'dart:collection';

import 'package:flutter/cupertino.dart';

class GeneralProvider with ChangeNotifier {

  BuildContext context;
  String selectedLanguage;

  GeneralProvider(this.context,this.selectedLanguage);
/*
  UnmodifiableListView<ProductsModel> get items =>
      UnmodifiableListView(productsList!);
*/

  String get userSelectedLanguage {
    return selectedLanguage;
  }

  setUserSelectedLanguage(String language){
    selectedLanguage = language;
    notifyListeners();
  }
}
