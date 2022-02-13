
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_tst/layout/news_app/cubit.dart';
import 'package:todo_app_tst/layout/news_app/states.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>NewsCubit(),
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,

              items: [
                BottomNavigationBarItem(
                  icon:Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.sports),
                  label:'Sports',
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.science),
                  label: 'Science',
                ),
                BottomNavigationBarItem(
                  icon:Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],

            ),

          );
        },

      ),
    );
  }
}
