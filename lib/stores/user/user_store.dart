import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/models/User/user.dart';

part 'user_store.g.dart';

enum StatusLogin { loading, logged, nonlogged }

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User user;


  @observable
  StatusLogin statusLogin = StatusLogin.loading;

  BehaviorSubject<StatusLogin> statusSubject = BehaviorSubject<StatusLogin>();

  @action
  setUser(User _user) {
    this.user = _user;
  }

  @action
  setStatusLogin(StatusLogin status) {
    this.statusLogin = status;
    statusSubject.add(this.statusLogin);
  }
}