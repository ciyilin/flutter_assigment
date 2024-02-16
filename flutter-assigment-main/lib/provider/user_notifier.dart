import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/data/user_datasource.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_state.dart';

class UserNotifier extends StateNotifier<UserState>{
  UserNotifier(UserState state):super (state);



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
    final updateUsers = state.users.where((user) => user.id != id).toList();
    state =state.copyWith(users: updateUsers);
  }

}