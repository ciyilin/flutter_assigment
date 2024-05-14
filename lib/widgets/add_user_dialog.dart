import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/utils/location_permission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class DialogAdd extends ConsumerWidget {
  const DialogAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final userNotifier = ref.watch(userProvider.notifier);

    void _handleSubmit(){
      String name = nameController.text.trim();//移除前後空白
      String email = emailController.text.trim();

      if(name.isEmpty ){
        showToast("User name cannot be empty");
      }else if(email.isEmpty){
        showToast("User email cannot be empty");
      }else{
        showToast("successfully");
      }
    }

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
            _handleSubmit();
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: ()  async{
            final name = nameController.text;
            final email = emailController.text;
<<<<<<< HEAD
            if(name.isEmpty || email.isEmpty){
              showToast("Name and email cannot be empty",
                  context: context,
                animation: StyledToastAnimation.none,
                position: StyledToastPosition.center,
              );
            }else{
              final newUser = User(name: name, email: email);
              await userNotifier.addUser(newUser);
            await userNotifier.loadUsers();}
=======
            final newUser = User(name: name, email: email);
            await userNotifier.addUser(newUser);
            await userNotifier.loadUsers();
>>>>>>> bebba83de3a3abec87cda99cc9780fc7e09a47ef
            Navigator.of(context).pop();
          },
          child: const Text('確定'),
        ),
      ],
    );
  }

}

