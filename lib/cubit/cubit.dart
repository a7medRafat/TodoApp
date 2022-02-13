import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_tst/Moduels/archived_tasks_screen.dart';
import 'package:todo_app_tst/Moduels/done_tasks_screen.dart';
import 'package:todo_app_tst/Moduels/new_tasks_screen.dart';
import 'package:todo_app_tst/constants/constants.dart';
import 'package:todo_app_tst/cubit/states.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  List<Widget> screens = [
    new_tasks(),
    done_tasks(),
    archived_tasks(),
  ];
  List <Map> newTasks =[];
  List <Map> doneTasks =[];
  List <Map> archiveTasks =[];


  void changeIndex (var index){

    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  late Database database;

  void createDatabase () {

         openDatabase(
        'todoapptst.db',
        version: 1,
        onCreate: (database ,version){
          print('database created !!!');
          database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT, time TEXT , date TEXT,status TEXT)')
              .then((value) {
            print('table created successfully');
          }).catchError((error){
            print('error when creating table ${error.toString()}');
          });
        },
        onOpen: (database){

          print('database opened');
        }
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
      getDataFromDatabase();
    });

  }

  Future insetToDateBase({@required title , @required time , @required date })async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks (title  , time ,date , status )VALUES ("$title"  ,"$time"," $date" ,"new")')
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase();
      }).catchError((error) {
        print('error in inserting data${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase() {

     database.rawQuery('SELECT * FROM tasks').then((value) {

        newTasks =[];
        doneTasks =[];
        archiveTasks =[];


       value.forEach((element) {
         if (element['status'] == 'new')
           newTasks.add(element);

         else if (element['status'] == 'done')
           doneTasks.add(element);
         else
           archiveTasks.add(element);
       });
       emit(GetDatabaseState());


     });
  }


void updateData ({
  required String statues,
  required int id
}) async {
  database.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      ['$statues', id]).then((value) {
    emit(UpdateDatabaseState());
    getDataFromDatabase();
  });

}

  void deleteDatabase({
    required int id
  }) async {
    database.rawDelete(
        'DELETE FROM tasks  WHERE id = ?',
        [id]).then((value) {
      emit(DeleteDatabaseState());
      getDataFromDatabase();
    });
  }


  var iconbtn = Icons.edit;
  bool isButtonEnabled = false;

  void changeButtonIcon({
    required bool enabledOrNot, required IconData icon
  }) {
    isButtonEnabled = enabledOrNot;
    iconbtn = icon;

    emit(AppChangeButtonSheetState());
  }





}