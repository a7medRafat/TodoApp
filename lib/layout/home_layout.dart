import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:todo_app_tst/Moduels/archived_tasks_screen.dart';
// import 'package:todo_app_tst/Moduels/done_tasks_screen.dart';
// import 'package:todo_app_tst/Moduels/new_tasks_screen.dart';
import 'package:todo_app_tst/components/components.dart';
import 'package:todo_app_tst/constants/constants.dart';
import 'package:todo_app_tst/cubit/cubit.dart';
import 'package:todo_app_tst/cubit/states.dart';

class home_layout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var myTitleController = TextEditingController();
  var myTimeController = TextEditingController();
  var myDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder:(context , state){

          AppCubit cubit =  AppCubit.get(context) ;


          return Scaffold(
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isButtonEnabled)
                {
                  if(formKey.currentState!.validate()){
                    cubit.insetToDateBase(title: myTitleController.text, time: myTimeController.text, date: myDateController.text).then((value) {
                      Navigator.pop(context);
                    });

                    cubit.changeButtonIcon(enabledOrNot: false, icon: Icons.edit);
                  }
                }
                else {
                  cubit.changeButtonIcon(enabledOrNot: true, icon: Icons.add);

                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      color: Colors.yellowAccent.shade700,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          child: Container(
                            color: Colors.grey.withOpacity(0.2),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defulatTextFiled(
                                    MyController: myTitleController,
                                    mySuffixIcon: Icons.title,
                                    validation: (value) {
                                      if (value.isEmpty) {
                                        return'title must not be empty';
                                      }
                                      return null;
                                    },
                                    labelTxt: 'Tasks Title',
                                    radius: BorderRadius.circular(0),
                                    txtType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defulatTextFiled(
                                      MyController: myTimeController,
                                      mySuffixIcon: Icons.watch_later,
                                      validation: (value) {
                                        if (value.isEmpty) {
                                          return'title must not be empty';
                                        }
                                        return null;
                                      },
                                      labelTxt: 'Tasks Time',
                                      radius: BorderRadius.circular(0),
                                      txtType: TextInputType.datetime,
                                      ontap: () {
                                        showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                            .then((value) {
                                          print(value!.format(context).toString());
                                          myTimeController.text =
                                              value.format(context).toString();
                                        });
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defulatTextFiled(
                                      MyController: myDateController,
                                      mySuffixIcon: Icons.date_range_outlined,
                                      validation: (value) {
                                        if (value.isEmpty) {
                                          return'title must not be empty';
                                        }
                                        return null;
                                      },
                                      labelTxt: 'Tasks Date',
                                      radius: BorderRadius.circular(0),
                                      txtType: TextInputType.datetime,
                                      ontap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse('2022-03-05'),
                                        ).then((value) {
                                          print(value.toString());
                                          myDateController.text = value.toString();
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      .closed
                      .then((value) {
                    cubit.changeButtonIcon(enabledOrNot: false, icon: Icons.edit);
                  });
                }
              },
              child: Icon(
                cubit.iconbtn,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 2,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              iconSize: 30,
              selectedFontSize: 17,
              selectedItemColor: Colors.white,
              backgroundColor: Colors.yellowAccent.shade700.withOpacity(0.1),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  label: 'New Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.black,
                  ),
                  label: 'Done Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                    color: Colors.black,
                  ),
                  label: 'Archived Tasks',
                ),
              ],
            ),
            body:
            cubit.screens[cubit.currentIndex],
            // ConditionalBuilder(
            //   condition: ,
            //   builder:(context)=> cubit.screens[cubit.currentIndex],
            //   fallback: (context) =>Center(
            //     child: CircularProgressIndicator
            //   ),
            // ),
            backgroundColor: Colors.white70,
          );
        } ,

      ),
    );
  }

}










  
