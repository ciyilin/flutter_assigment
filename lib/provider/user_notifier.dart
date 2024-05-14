import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/data/user_datasource.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(UserState state) : super(state);

  List<User> _userList = [];


  //載入用戶數據
  Future<void> loadUsers() async {
    final List<User> users = await UserDatasource.getUsers();
    state = state.copyWith(users: users);
  }

  //新增
  Future<void> addUser(User user) async {
    await UserDatasource.addUser(user);
    state.users??[];
    _userList??[];
    state = state.copyWith(users: [...state.users!, user]);
    print('新增用戶：${user.id},${user.name},${user.email}');
  }

  //delete
  Future<void> deleteUser(int id) async {
    try{
      await UserDatasource.deleteUser(id);
    _userList??=[];
    _userList!.removeWhere((element) => element.id == id);
    state = List<User>.from(_userList!) as UserState ;
    }catch(e){
      print('Faile to delete user:$e');
    }
  }

  //update
  Future<void> updateUser(User user) async {
    UserDatasource.updateUser(user);
    state.users??[];
    state = UserState(
      users: state.users!.map((existingUser) {
        if (existingUser.id == user.id) {
          return User(name: user.name, email: user.email);
        } else {
          return existingUser;
        }
      }).toList(),
    );
  }
}
