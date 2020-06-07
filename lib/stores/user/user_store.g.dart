// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  User get user {
    _$userAtom.context.enforceReadPolicy(_$userAtom);
    _$userAtom.reportObserved();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.context.conditionallyRunInAction(() {
      super.user = value;
      _$userAtom.reportChanged();
    }, _$userAtom, name: '${_$userAtom.name}_set');
  }

  final _$statusLoginAtom = Atom(name: '_UserStore.statusLogin');

  @override
  StatusLogin get statusLogin {
    _$statusLoginAtom.context.enforceReadPolicy(_$statusLoginAtom);
    _$statusLoginAtom.reportObserved();
    return super.statusLogin;
  }

  @override
  set statusLogin(StatusLogin value) {
    _$statusLoginAtom.context.conditionallyRunInAction(() {
      super.statusLogin = value;
      _$statusLoginAtom.reportChanged();
    }, _$statusLoginAtom, name: '${_$statusLoginAtom.name}_set');
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  dynamic setUser(User _user) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setUser(_user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStatusLogin(StatusLogin status) {
    final _$actionInfo = _$_UserStoreActionController.startAction();
    try {
      return super.setStatusLogin(status);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'user: ${user.toString()},statusLogin: ${statusLogin.toString()}';
    return '{$string}';
  }
}
