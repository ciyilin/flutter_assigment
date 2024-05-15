import 'package:riverpod/riverpod.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/data/user_datasource.dart';

class UserState {
  final List<User> users;
  const UserState({this.users = const []});
  // 初始空状态
  static const initial = UserState();
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(UserState initial) : super(UserState.initial);

  List<User> _originalUsers = [];
  get originalUsers => _originalUsers;


  //載入用戶數據

  Future<void> loadUsers() async {
    final List<User> users = await UserDatasource.getUsers();
    state = UserState(users: users);
  }

  Future<void> addUser(User user) async {
    await UserDatasource.addUser(user);
    state = UserState(users: [...state.users, user]);
    print('新增用戶：${user.id},${user.name},${user.email}');
  }

  Future<void> deleteUser(int id) async {
    await UserDatasource.deleteUser(id);
    state =
        UserState(users: state.users.where((user) => user.id != id).toList());
  }

  Future<void> updateUser(User newUser) async {
    try{
      //先更新user的資料
      await UserDatasource.updateUser(newUser);
      //再更新狀態
      final updateUsers = state.users.map((user) =>
      user.id == newUser.id ? newUser : user).toList();
      state = UserState(users: updateUsers);
      print('Success to update');
    }catch(e){
      print('Failed to update:$e');
    }
  }
}
