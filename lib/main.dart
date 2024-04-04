import 'package:dog_health/components/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(
              255, 139, 78, 244), // Establece el color del AppBar aquí
        ),
      ),
    );
  }
}
