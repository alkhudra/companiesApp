import 'package:flutter/material.dart';

Future<void> _displayTextInputDialog(BuildContext context,TextEditingController _textFieldController) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            onChanged: (value) {

            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
        );
      });
}