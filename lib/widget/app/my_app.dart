import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/navigation/main_navigation.dart';
import 'package:themoviedb/widget/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 3, 37, 65)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 3, 37, 65),
            unselectedItemColor: Color.fromARGB(255, 175, 175, 175),
            selectedItemColor: Colors.white,
            selectedLabelStyle:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            unselectedIconTheme: IconThemeData(size: 22),
            selectedIconTheme: IconThemeData(size: 24)),
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
