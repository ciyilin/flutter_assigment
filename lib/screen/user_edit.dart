import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/User.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/screen/my_home_page.dart';
import 'package:fluttertest/utils/utils.dart';

import '../widgets/custom_text_field.dart';

class UserEditor extends ConsumerStatefulWidget {
  final User user;
  const UserEditor( {Key? key,required this.user}) : super(key: key);

  @override
  _UserEditorState createState() => _UserEditorState();
}

class _UserEditorState extends ConsumerState<UserEditor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();



  @override
  void initState() {
    super.initState();
    // 设置控制器的初始值
    _nameController.text = widget.user.name!;
    _emailController.text =widget.user.email!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateUser(){
    final newName = _nameController.text;
    final newEmail = _emailController.text;
    final updateUser = User(name: newName, email: newEmail,id:widget.user.id );
    ref.read(userProvider.notifier).updateUser(updateUser);
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    return Scaffold(
        backgroundColor: color.background,
        appBar: AppBar(
          backgroundColor: color.primary,
          title: const Text('Edit User Profile'),
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
                      onPressed:() {
                        _updateUser();
                      },
                      style: ButtonStyle(shape:MaterialStateProperty.all(RoundedRectangleBorder
                        (borderRadius: BorderRadius.circular(10)))),
                      child: const Text('更新',style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  )
                ])));
  }
}

