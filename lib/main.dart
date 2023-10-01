import 'package:flutter/material.dart';
import 'package:frontend_test_imagineapps/Core/providers/task_provider.dart';
import 'package:frontend_test_imagineapps/UI/Screens/Task%20screeens/tasks_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../../Core/Constants/colors.dart';
import '../../Core/Constants/strings.dart';
import '../../Core/providers/signup_provider.dart';

import '../../UI/Screens/Authentication/login_screen.dart';
import '../../UI/Screens/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Core/providers/login_provider.dart';

int? initScreen;
SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();
  initScreen = (prefs?.getInt("initScreen"));
  prefs?.setInt("initScreen", 1);

  var token = (prefs?.getString("token"));

  if (token != null) initScreen = 2;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: GetMaterialApp(
        title: 'ToDo app',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'MyFont',
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                centerTitle: true, foregroundColor: kWhite, toolbarHeight: 70),
            scaffoldBackgroundColor: kBGColor),
        initialRoute: initScreen == 0 || initScreen == null
            ? "/"
            : initScreen == 2
                ? "task"
                : "home",
        routes: {
          '/': (context) => const MyIntroductionScreen(),
          'home': (context) => const LoginScreen(),
          'task': (context) => const TasksScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
