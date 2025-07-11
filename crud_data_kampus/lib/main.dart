import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/form_kampus_page.dart';
import 'pages/list_kampus_page.dart';
import 'model/kampus_model.dart';

void main() {
  runApp(const DataKampusApp());
}

class DataKampusApp extends StatelessWidget {
  const DataKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Kampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black87, fontSize: 20),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/list': (context) => const ListKampusPage(),
        '/form': (context) {
          final kampus = ModalRoute.of(context)?.settings.arguments as Kampus?;
          return FormKampusPage(kampus: kampus);
        },
      },
    );
  }
}
