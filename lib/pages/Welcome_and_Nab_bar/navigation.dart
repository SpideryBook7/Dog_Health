import 'package:dog_health/pages/Realtime/Canino_page.dart';
import 'package:dog_health/pages/Realtime/HealthScreen.dart';
import 'package:dog_health/pages/Realtime/Logs.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hide the system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: 'Curved Navigation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuScreenState();
  }
}

class MenuScreenState extends StatefulWidget {
  const MenuScreenState({Key? key}) : super(key: key);

  @override
  State<MenuScreenState> createState() => _MenuScreenStateState();
}

class _MenuScreenStateState extends State<MenuScreenState> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 229, 255),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        color: Color.fromARGB(255, 47, 146, 185),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.health_and_safety, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.report, color: Colors.white),
        ],
      ),
      body: _getPage(_pageIndex),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return WelcomeScreen();
      case 1:
        return CaninoList();
      case 2:
        return HealthScreen();
      case 3:
        return LogsScreen();
      default:
        return Container();
    }
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¡Bienvenido a la App de Información de tu Canino!',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Esta aplicación te permite realizar un seguimiento detallado de la salud y el bienestar de tu mascota, información del canino, el monitoreo de los estados de salud y el estado de registros, tendrás todo lo que necesitas para cuidar a tu amigo peludo.',
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
