import 'package:flutter/material.dart';
import 'package:fluttertest/utils/extensions.dart';
import 'package:fluttertest/widgets/user_list.dart'; // Import UserListWidget
import '../widgets/add_user_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _searchController;

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const Text('Flutter Assignment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const UserListWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const DialogAdd();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
