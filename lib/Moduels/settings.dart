import 'dart:html';

import 'package:flutter/cupertino.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen ',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),),
    );
  }
}
