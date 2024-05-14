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
  UserNotifier(UserState state) : super(state);

  Future<void> loadUsers() async {
    final List<User> users = await UserDatasource.getUsers();
    state = UserState(users: users);
  }

  Future<void> addUser(User user) async {
    await UserDatasource.addUser(user);
    state = UserState(users: [...state.users, user]);
  }

  Future<void> deleteUser(int id) async {
    await UserDatasource.deleteUser(id);
    state = UserState(users: state.users.where((user) => user.id != id).toList());
  }

  Future<void> updateUser(User updatedUser) async {
    await UserDatasource.updateUser(updatedUser);
    final users = state.users.map((user) => user.id == updatedUser.id ? updatedUser : user).toList();
    state = UserState(users: users);
  }
}
