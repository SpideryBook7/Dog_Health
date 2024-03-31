import 'package:dog_health/pages/Canino_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dog_health/pages/Logs.dart';
import 'package:dog_health/pages/Stadistics.dart';
import 'package:flutter/services.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hide the system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: _MenuScreenState(),
    );
  }
}

class _MenuScreenState extends StatefulWidget {
  @override
  State<_MenuScreenState> createState() => _MenuScreenStateState();
}

//Navigation
class _MenuScreenStateState extends State<_MenuScreenState>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        WelcomeScreen(), // Pantalla de bienvenida
        CaninoList(), // Pantalla de información del perro
        HealthScreen(), // Pantalla de estados de salud
        RecordsScreen(), // Pantalla de registros
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.withOpacity(0.8),
                  Colors.blue.withOpacity(0.2)
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(3),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Inicio"),
                Tab(text: "Canino"),
                Tab(text: "Salud"),
                Tab(text: "Registros"),
              ],
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
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
