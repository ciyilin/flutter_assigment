import 'package:equatable/equatable.dart';
import '../models/User.dart';

class UserState extends Equatable {
  final List<User> users;

  const UserState({
    required this.users,
  });

  const UserState.initial({
    this.users = const [],
  });

  UserState copyWith({
    List<User>? users,
  }) {
    return UserState(
      users: users ?? this.users,
    );
  }
  
  //自定義map方法
  List<T Function(User user)>map<T>(T Function(User)callback){
    return users.map((e) => callback).toList();
  }
  

  @override
  List<Object?> get props => [users];
}
