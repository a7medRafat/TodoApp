import 'dart:html';

import 'package:flutter/cupertino.dart';

class Business_Screen extends StatelessWidget {
  const Business_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Business Screen ',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),),
    );
  }
}
