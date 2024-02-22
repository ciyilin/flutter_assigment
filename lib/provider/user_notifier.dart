import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/data/user_datasource.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/provider/user_state.dart';

class UserNotifier extends StateNotifier<UserState>{
  UserNotifier(UserState state):super (state);
  final List<User> _userList =[];



  //在入用戶數據
  Future<void> loadUsers() async{
    final List<User> users = await UserDatasource.getUsers();
    state =state.copyWith(users: users);
  }

  //新增
  Future<void> addUser(User user) async {
    await UserDatasource.addUser(user);
    state = state.copyWith(users: [...state.users, user]);
  }

  //delete
  Future<void> deleteUser(int id) async{
    await UserDatasource.deleteUser(id);
    _userList.removeWhere((element) => element.id == id);
    // Remove the user with the provided id from the list
    // final updateUsers = state.users.where((user) => user.id != id).toList();
    // state =state.copyWith(users: updateUsers);
  }
  //update
  List<User> get user => user;

  Future<void>updateUser(User user)async{
    UserDatasource.updateUser(user).then((value){
      loadUsers();
    });


    // 更新數據酷的用戶資料
    // await UserDatasource.updateUser(user);
    //更新應用程式狀態
    // state = state.copyWith(
    //   users: state.users.map((user) {
    //     if (user.id == id) {
    //       return user.copyWith(name: newName, email: newEmail);
    //     } else {
    //       return user;
    //     }
    //   }).toList(),
    // );
  }
}