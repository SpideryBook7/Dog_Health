import 'package:flutter/material.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    HealthWidget(
                      label: 'Temperatura',
                      value: 75,
                      details: 'La temperatura está en un estado aceptable.',
                      icon: Icons.thermostat_outlined,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: 20),
                    HealthWidget(
                      label: 'Pulso Cardiaco',
                      value: 60,
                      details: 'El ritmo cardíaco en bpm es aceptable.',
                      icon: Icons.favorite_outline,
                      color: Colors.green,
                    ),
                  ],
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
          crossAxisAlignment:
              CrossAxisAlignment.center, // Changed crossAxisAlignment
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
                      value: value / 100,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  ),
                  Center(
                    child: Text(
                      '$value%',
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
