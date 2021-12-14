import 'package:flutter/material.dart';
import 'package:khudrah_companies/designs/ButtonsDesign.dart';
import 'package:khudrah_companies/locale/language_const.dart';
import 'package:khudrah_companies/resources/custom_colors.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
/*  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }*/

  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'home_page')),
        actions: <Widget>[
       /*   Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),*/
        ],
      ),

      body: Center(
        child: SafeArea(
          child: Container(

            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Image(
                  height: 100,
                  image: AssetImage('images/logo.jpg'),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    print(getTranslated(context, 'personal_information'));
                  },
                  height: ButtonsDesign.buttonsHeight,
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText('English'),
                  color: CustomColors().primaryGreenColor,
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {
                    print(getTranslated(context, 'personal_information'));
                  },
                  height: ButtonsDesign.buttonsHeight,
                  shape: StadiumBorder(),
                  child: ButtonsDesign.buttonsText('العربية'),
                  color: CustomColors().primaryGreenColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
