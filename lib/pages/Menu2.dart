import 'package:flutter/material.dart';
import 'package:dog_health/pages/Logs.dart';
import 'package:dog_health/pages/Stadistics.dart';
import 'package:dog_health/pages/Canino_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hide the system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: 'Curved Navigation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MenuScreenState(),
    );
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
        backgroundColor: Color.fromARGB(255, 127, 197, 255),
        color: Colors.deepPurple.shade600,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.date_range, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
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
        return RecordsScreen();
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.withOpacity(0.2), Colors.blue.withOpacity(0.1)],
        ),
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
            'Esta aplicación te permite realizar un seguimiento detallado de la salud y el bienestar de tu mascota. Con características como la visualización de la información del canino, el monitoreo de los estados de salud y el estado de registros, tendrás todo lo que necesitas para cuidar a tu amigo peludo.',
            style: TextStyle(fontSize: 19, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
