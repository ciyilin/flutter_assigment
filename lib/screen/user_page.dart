import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/screen/my_home_page.dart';
import 'package:fluttertest/utils/utils.dart';

import '../widgets/custom_text_field.dart';

class UserPage extends ConsumerStatefulWidget {
  final User user;

  const UserPage({Key? key, required this.user}) : super(key: key);

  @override
  _UesrPageState createState() => _UesrPageState();
}

class _UesrPageState extends ConsumerState<UserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return Scaffold(
        backgroundColor: color.background,
        appBar: AppBar(
          backgroundColor: color.primary,
          title: const Text('User Page'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFiled(
                      controller: _nameController,
                      labelText: 'Name'
                  ),
                  const SizedBox(height: 20),
                  CustomTextFiled(
                      controller: _emailController,
                      labelText: "Email"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _updateUserData,
                      style: ButtonStyle(shape:MaterialStateProperty.all(RoundedRectangleBorder
                        (borderRadius: BorderRadius.circular(10)))),
                      child: const Text('更新',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  )
                ])));
  }
  void _updateUserData(User user){
    final newName = _nameController.text;
    final newEmail = _emailController.text;
    final userId = widget.user.id;
    //調用 userProvider StateNotifier的updateUser
    ref.watch(userProvider.notifier).updateUser(user);
    Navigator.pop(context);
  }
}

