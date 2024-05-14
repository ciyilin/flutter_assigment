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

<<<<<<< HEAD
=======
  List<User> _userList = [];


  //載入用戶數據
>>>>>>> bebba83de3a3abec87cda99cc9780fc7e09a47ef
  Future<void> loadUsers() async {
    final List<User> users = await UserDatasource.getUsers();
    state = UserState(users: users);
  }

  Future<void> addUser(User user) async {
    await UserDatasource.addUser(user);
<<<<<<< HEAD
    state = UserState(users: [...state.users, user]);
=======
    state.users??[];
    _userList??[];
    state = state.copyWith(users: [...state.users!, user]);
    print('新增用戶：${user.id},${user.name},${user.email}');
>>>>>>> bebba83de3a3abec87cda99cc9780fc7e09a47ef
  }

  Future<void> deleteUser(int id) async {
<<<<<<< HEAD
    await UserDatasource.deleteUser(id);
    state = UserState(users: state.users.where((user) => user.id != id).toList());
  }

  Future<void> updateUser(User updatedUser) async {
    await UserDatasource.updateUser(updatedUser);
    final users = state.users.map((user) => user.id == updatedUser.id ? updatedUser : user).toList();
    state = UserState(users: users);
=======
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
>>>>>>> bebba83de3a3abec87cda99cc9780fc7e09a47ef
  }
}
