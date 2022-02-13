import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tst/Moduels/business.dart';
import 'package:todo_app_tst/Moduels/science.dart';
import 'package:todo_app_tst/Moduels/settings.dart';
import 'package:todo_app_tst/Moduels/sports.dart';
import 'package:todo_app_tst/layout/news_app/states.dart';

 class NewsCubit extends Cubit{

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) =>BlocProvider.of(context);

  int CurrentIndex = 0;

List <Widget> News_Screens =[
  Business_Screen(),
  Sports_Screen(),
  Science_Screen(),
  Settings_Screen(),
];

}


