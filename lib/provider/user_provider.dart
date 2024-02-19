import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/provider/user_notifier.dart';
import 'package:fluttertest/provider/user_state.dart';

final userProvider = StateNotifierProvider<UserNotifier,UserState>((ref) {
  return UserNotifier(const UserState.initial());
});