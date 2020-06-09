import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/Entry/entry.dart';
import 'package:task/screens/Home/home.dart';
import 'package:task/screens/Task/edit_task.dart';
import 'package:task/screens/Task/new_task.dart';
import 'package:task/services/TaskService.dart';
import 'package:task/services/UserService.dart';
import 'package:task/stores/task/task_store.dart';
import 'package:task/stores/user/user_store.dart';
import 'package:task/utils/navigator.dart';

import 'models/Task/task.dart';

                //PROF QUALQUER PROBLEMA ESSE PROJETO TA NO GIT https://github.com/imjvictor98/flutter-tasks
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MultiProvider(providers: [
          Provider<UserService>(
            create: (_) => UserService(UserStore()),
            dispose: (ctx, userService) {
              userService.dispose();
            },
          ),
          Provider<TaskService>(
            create: (_) => TaskService(TaskStore()),
            dispose: (ctx, taskService) {
              taskService.dispose();
            },
          ),
        ],
        child: MaterialApp(
          title: "Tasks",  
          navigatorObservers: [BotToastNavigatorObserver()],      
          navigatorKey: NavigatorUtils.nav,
          initialRoute: "entry",
          routes: {
            "entry": (context) => Entry(),  //Where user put his name
            "home": (context) => HomeState(), //Where are task's user
            "new_task": (context) => TaskScreen(), //Where user add a new task to a list
            "edit_task": (context) => EditTaskScreen(),
          },
          theme: ThemeData(
            backgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(
              buttonColor: Color.fromRGBO(1, 43, 127, 1),
              textTheme: ButtonTextTheme.primary,            
            ),
          ),
        ),
      ),
    );
  }
}


