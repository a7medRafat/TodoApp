import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_tst/cubit/cubit.dart';

Widget defulatTextFiled({
  required TextEditingController MyController,
  required IconData mySuffixIcon,
  required final validation,
  required String labelTxt,
  required BorderRadius radius,
  required TextInputType txtType,
  final ontap,
}) =>
    TextFormField(
      keyboardType: txtType,
      onTap: ontap,
      validator: validation,
      controller: MyController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: radius,
        ),
        prefixIcon: Icon(
          mySuffixIcon,
          color: Colors.black,
        ),
        labelText: labelTxt,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );

Widget defultTasksItem(Map model, context) =>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: model['id']);
  },

  child:   Row(
  
        children: [
  
          CircleAvatar(
  
            backgroundColor: Colors.black,
  
            child: Text(
  
              '${model["time"]}',
  
              style: TextStyle(
  
                  fontSize: 15,
  
                  color: Colors.white70,
  
                  fontWeight: FontWeight.bold),
  
            ),
  
            radius: 37,
  
          ),
  
          SizedBox(
  
            width: 14,
  
          ),
  
          Expanded(
  
            child: Column(
  
              children: [
  
                Text(
  
                  '${model["title"]}',
  
                  style: TextStyle(
  
                      fontSize: 25,
  
                      fontWeight: FontWeight.bold,
  
                      color: Colors.black),
  
                ),
  
                SizedBox(
  
                  height: 3,
  
                ),
  
                Text(
  
                  '${model["date"]}',
  
                  style: TextStyle(
  
                    fontSize: 15,
  
                    fontWeight: FontWeight.bold,
  
                    color: Colors.black54,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
          SizedBox(
  
            width: 14,
  
          ),
  
          IconButton(
  
            onPressed: () {
  
              AppCubit.get(context).updateData(statues: 'done', id: model['id']);
  
            },
  
            icon: Icon(Icons.check_box),
  
            color: Colors.green,
  
          ),
  
          IconButton(
  
            onPressed: () {
  
              AppCubit.get(context)
  
                  .updateData(statues: 'archive', id: model['id']);
  
            },
  
            icon: Icon(Icons.archive),
  
          ),
  
        ],
  
      ),
);
