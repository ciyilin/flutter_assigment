import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/screen/my_home_page.dart';
import 'package:fluttertest/utils/extensions.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: colors.onPrimary,
      ),
      home: const MyHomePage(),
    );
  }
}

void requestLocationPermission() async {
  var status = await Permission.locationWhenInUse.request();
  if (status.isGranted) {
    print('Location is Granted');
  } else if (status.isDenied) {
    print('Location is Defined');
  } else if (status.isPermanentlyDenied) {
    print('Location is PermanentlyDenied');
  }
}
