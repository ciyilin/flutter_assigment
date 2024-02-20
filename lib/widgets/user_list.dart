import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/screen/detail_page.dart';
import 'package:fluttertest/utils/extensions.dart';
import 'package:go_router/go_router.dart';
import '../models/User.dart';
import 'package:fluttertest/router/router.dart';



class UserListWidget extends ConsumerStatefulWidget {
  const UserListWidget({Key? key}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends ConsumerState<UserListWidget> {
  late final TextEditingController _searchController;

  int get id => id;

  String get name => name;

  String get email => email;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final userListState = ref.watch(userProvider);
    final userList = userListState.users;
    final searchText = _searchController.text;
    final userNotifier = ref.watch(userProvider.notifier);
    var filteredUsers = _filterUsers(searchText, userList);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
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
                _searchController.text = value;
              });
              filteredUsers = _filterUsers(searchText, userList);
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return GestureDetector(
                  onTap: (){
                    return context.go('detail');
                  },
                  child: Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    dragDismissible: true,
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        userNotifier.deleteUser(user.id).then((_) {
                          log("successful delete");
                        });
                      },
                    ),
                    children: const <Widget>[
                      SlidableAction(
                        onPressed:doNothing ,
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset('assets/image/user.png'),
                    ),
                    title: Text(
                      user.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    subtitle: Text(
                      user.email!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  ));
              },
            ),
          ),
        ],
      ),
    );
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
}

void doNothing(BuildContext context) {}
