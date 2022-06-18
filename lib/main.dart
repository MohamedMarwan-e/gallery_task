import 'package:flutter/material.dart';
import 'package:gallery_task/controller/favorites_provider.dart';
import 'package:gallery_task/controller/home_provider.dart';
import 'package:gallery_task/controller/nav_bar_provider.dart';
import 'package:gallery_task/controller/search_provider.dart';
import 'package:gallery_task/services/components/remote/dio_helper.dart';
import 'package:gallery_task/view/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  runApp(
      MultiProvider(
          providers: [
           ChangeNotifierProvider(create: (context) => HomeProvider()),
           ChangeNotifierProvider(create: (context) => SearchProvider()),
           ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
           ChangeNotifierProvider(create: (context) => FavoriteProvider()),
          ],
       child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}


