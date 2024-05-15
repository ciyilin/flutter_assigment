import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertest/provider/user_provider.dart';
import '../models/User.dart';
import '../screen/user_edit.dart';

class UserListWidget extends ConsumerStatefulWidget {
  const UserListWidget({Key? key}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends ConsumerState<UserListWidget> {
  late final TextEditingController _searchController = TextEditingController();

  int get id => id;

  @override
  void initState() {
    super.initState();
    _searchController;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userListState = ref.watch(userProvider);
    final userList = userListState.users;
    final searchText = _searchController.text;
    final filterUser = _filterUsers(searchText, userList);

    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
                gapPadding: 8,
              ),
            ),
            onChanged: (value) {
              setState(() {
                filterUser;
              });
            },
          ),
          const SizedBox(height: 12),
          Expanded(
              child: ListView.builder(
                  itemCount: _filterUsers(searchText, userList).length,
                  itemBuilder: (context, index) {
                    final user = _filterUsers(searchText, userList)[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) => UserEditor(user: user,)));
                        },
                        child: Dismissible(
                            key: ValueKey(user.id),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              if (user.id != null) {
                                ref.watch(userProvider.notifier).deleteUser(user.id!).then((_) {
                                  setState(() {
                                    ref.watch(userProvider.notifier).loadUsers();
                                  });
                                  log("successful delete");
                                });
                              } else {
                                log("Error:User ID null");
                              }
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              child: const Icon(Icons.delete,color: Colors.white),
                            ),
                            child: ListTile(
                                leading: CircleAvatar(
                                  child: Image.asset(
                                    'assets/image/user.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                title: Text(
                                  user.name!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                subtitle: Text(
                                  user.email ?? "",
                                  style: const TextStyle(fontSize: 12),
                                ))));
                  }))
        ]));
  }

  List<User> _filterUsers(String searchText, List<User> userList) {
    // 如果搜尋內容為空 回傳列表;過濾列表
    if (searchText.isEmpty) {
      return userList;
    }
    return userList
        .where((user) =>
            user.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  void doNothing(BuildContext context) {}
}

