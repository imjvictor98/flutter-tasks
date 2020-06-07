import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/Entry/entry.dart';
import 'package:task/screens/Home/home.dart';
import 'package:task/screens/Task/new_task.dart';
import 'package:task/services/UserService.dart';
import 'package:task/stores/user/user_store.dart';
import 'package:task/utils/navigator.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        Provider<UserService>(
          create: (_) => UserService(UserStore()),
          dispose: (ctx, userService) {
            userService.dispose();
          },
        ),
      ],
      child: MaterialApp(
        title: "Tasks",        
        navigatorKey: NavigatorUtils.nav,
        initialRoute: "entry",
        routes: {
          "entry": (context) => Entry(),
          "home": (context) => HomeState(),
          "new_task": (context) => TaskScreen(),
        },
        theme: ThemeData(
          backgroundColor: Colors.white,
          buttonTheme: ButtonThemeData(
            buttonColor: Color.fromRGBO(1, 43, 127, 1),
            textTheme: ButtonTextTheme.primary,            
          ),
        ),
      ),
    );
  }
}


