import 'package:flutter/material.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class DialogAdd extends ConsumerWidget {
  const DialogAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: '');
    final emailController = TextEditingController(text: '');
    final userNotifier = ref.watch(userProvider.notifier);

    return AlertDialog(
      title: const Center(child: Text('新增用戶', style: TextStyle(fontSize: 12))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'User name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'User email'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: ()  {
            final name = nameController.text;
            final email = emailController.text;
            final newUser = User(name: name, email: email, id: 0);  //0為默認值
            userNotifier.addUser(newUser);
            Navigator.of(context).pop();
          },
          child: const Text('確定'),
        ),
      ],
    );
  }

}

