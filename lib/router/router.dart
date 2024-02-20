import 'package:fluttertest/screen/detail_page.dart';
import 'package:fluttertest/screen/my_home_page.dart';
import 'package:go_router/go_router.dart';


final router = GoRouter(
    debugLogDiagnostics: true,
    
    routes:[
    GoRoute(
    path: '/',
    builder: (context, state) => MyHomePage(),
    routes: [
    GoRoute(
        path: 'detail',
    builder: (context,state)=> DetailPage()
    )])
    ]
);