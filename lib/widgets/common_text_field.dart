import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/provider/user_provider.dart';
import 'package:fluttertest/utils/extensions.dart';



class CommonTexField extends ConsumerStatefulWidget {
  const CommonTexField({super.key});



  @override
  _CommonTexFieldState createState() => _CommonTexFieldState();
}


class _CommonTexFieldState extends ConsumerState<CommonTexField> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final color = context.colorScheme;
    final userListState = ref.watch(userProvider);
    final userList = userListState.users;
    // final nameController = TextEditingController(text: userList.);
    // final emailController = TextEditingController(text: userProvider.);
    return Column(
      children: [
        Title(
            color: color.secondary,
            child: const Text(
              "Name",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.normal),
            )),
        const SizedBox(height: 8),
        TextField(
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.cyan,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    );
  }
}









