import 'package:flutter/material.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'En este apartado podrás visualizar el estado de tu canino en tiempo real.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      HealthWidget(
                        label: 'Temperatura.',
                        value: 75,
                        details: 'La temperatura está en un estado aceptable.',
                      ),
                      SizedBox(height: 20),
                      HealthWidget(
                        label: 'Pulso Cardiaco.',
                        value: 60,
                        details: 'El ritmo cardíaco en bpm es aceptable.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthWidget extends StatelessWidget {
  final String label;
  final int value;
  final String details;

  HealthWidget({
    required this.label,
    required this.value,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 3),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CircularProgressIndicator(
                    value: value / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Center(
                  child: Text(
                    '$value%',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    '$value%',
                    style: TextStyle(fontSize: 20),
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
    );
  }
}
