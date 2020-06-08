import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/User/user.dart';
import 'package:task/stores/user/user_store.dart';

class UserService {
  final UserStore userStore;
  SharedPreferences _preferences;
  StreamSubscription<StatusLogin> _statusLoginSubscription;

  UserService(this.userStore) {
    SharedPreferences.getInstance().then((value){
      _preferences = value;
    });
  }

  Future<User> login(String name) async {
    User user = User(name: name);

    _preferences.setString("user", jsonEncode(user.toJson()));

    userStore.setUser(user);
    userStore.setStatusLogin(StatusLogin.logged);

    return Future.value(user);
  }

  Future<User> getUser() async {
    return Future.delayed(Duration(seconds: 2), ()  {
      String userStr = _preferences.getString("user");

      User user = User.fromJson(jsonDecode(userStr)); 

      return user;
    });
  }

  Future<User> createUser(String name) {
    return Future.value(User(name: name));
  }


  Future<void> logout() {
    _preferences.remove("user");
    userStore.setStatusLogin(StatusLogin.nonlogged);
  }

  Future<User> verifyUser() async {
  
    return Future.delayed(Duration(seconds: 5), () {
      String userStr = _preferences.getString("user");

      if (userStr != null) {
        User userLogged = User.fromJson(jsonDecode(userStr));

        userStore.setUser(userLogged);
        userStore.setStatusLogin(StatusLogin.logged);

        return userLogged;
      } else {
        userStore.setStatusLogin(StatusLogin.nonlogged);
        return null;
      }
    });
    
  }


  void dispose() {
    _statusLoginSubscription.cancel();
  }


}