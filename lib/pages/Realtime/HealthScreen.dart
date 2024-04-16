import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HealthScreen extends StatefulWidget {
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  double _temperature = 0.0;
  int _pulse = 0;

  @override
  void initState() {
    super.initState();
    // Suscribe a los cambios en la base de datos para mantener actualizados los valores
    _databaseReference
        .child('historial')
        .child('Temperatura')
        .onValue
        .listen((event) {
      final dynamic temperaturaData = event.snapshot.value;
      if (temperaturaData != null && temperaturaData is Map<dynamic, dynamic>) {
        // Obtener el valor más reciente de temperatura
        final String latestKey = temperaturaData.keys.last;
        final double latestTemperature = temperaturaData[latestKey].toDouble();
        setState(() {
          _temperature = latestTemperature;
        });
      }
    });

    _databaseReference
        .child('historial')
        .child('Pulso')
        .onValue
        .listen((event) {
      final dynamic pulsoData = event.snapshot.value;
      if (pulsoData != null && pulsoData is Map<dynamic, dynamic>) {
        // Obtener el ID más alto
        int highestId = 0;
        int highestPulse = 0;
        pulsoData.forEach((key, value) {
          int currentId = int.tryParse(key) ?? 0;
          if (currentId > highestId) {
            highestId = currentId;
            highestPulse = value.toInt();
          }
        });
        setState(() {
          _pulse = highestPulse;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Aquí se envuelve en SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    HealthWidget(
                      label: 'Temperatura',
                      value: _temperature,
                      details:
                          'La temperatura de tu canino está en un estado aceptable.',
                      icon: Icons.thermostat_outlined,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: 20),
                    HealthWidget(
                      label: 'Pulso Cardiaco',
                      value: _pulse.toDouble(), // Mantener el valor como double
                      details:
                          'El ritmo cardíaco de tu canino en bpm es aceptable.',
                      icon: Icons.favorite_outline,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthWidget extends StatelessWidget {
  final String label;
  final double value; // Cambiado de int a double para la temperatura
  final String details;
  final IconData icon;
  final Color color;

  HealthWidget({
    required this.label,
    required this.value,
    required this.details,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CircularProgressIndicator(
                      value: value /
                          100, // Solo para mantener el tamaño del círculo
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${value.toStringAsFixed(1)}', // Mostrar solo un decimal
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              details,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
