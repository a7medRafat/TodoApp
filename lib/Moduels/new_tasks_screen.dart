import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tst/components/components.dart';
import 'package:todo_app_tst/constants/constants.dart';
import 'package:todo_app_tst/cubit/cubit.dart';
import 'package:todo_app_tst/cubit/states.dart';

class new_tasks extends StatelessWidget {
  const new_tasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit ,AppStates>(
      listener: (BuildContext context, state) { },
      builder:  (context , state){
          var tasks = AppCubit.get(context).newTasks;

        return ListView.separated(
          itemBuilder: (context,index)=>Padding(
            padding: const EdgeInsets.all(15),
            child: defultTasksItem(tasks[index] , context),
          ),
          separatorBuilder: (context , index) => Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 1,
              color:  Colors.black26,
            ),
          ),
          itemCount: tasks.length,
        );
      },

    );
  }
}
