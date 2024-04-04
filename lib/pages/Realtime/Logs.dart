import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';

class LogsScreen extends StatefulWidget {
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  // Datos iniciales de ejemplo
  List<double> temperatureData = [];
  List<double> heartRateData = [];
  List<double> humidityData = [];
  bool loading = true; // Variable para controlar si se están cargando los datos

  // Temporizador para simular la actualización de datos cada 10 minutos
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador
    _startTimer();
  }

  @override
  void dispose() {
    // Detener el temporizador cuando se elimine el widget
    _timer.cancel();
    super.dispose();
  }

  // Función para iniciar el temporizador
  void _startTimer() {
    // Actualizar los datos cada 10 minutos
    const period = Duration(minutes: 10);
    _timer = Timer.periodic(period, (Timer t) {
      // Actualizar los datos de ejemplo
      _updateData();
    });
  }

  // Función para actualizar los datos de ejemplo
  void _updateData() {
    setState(() {
      // Actualizar los datos con valores aleatorios entre 70 y 100
      temperatureData.add(_getRandomValue());
      heartRateData.add(_getRandomValue());
      humidityData.add(_getRandomValue());
      loading =
          false; // Cuando los datos están cargados, establecer loading en falso
    });
  }

  // Función para obtener un valor aleatorio entre 70 y 100
  double _getRandomValue() {
    return 70 + (30 * DateTime.now().millisecondsSinceEpoch % 100) / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Gráfica de Registros',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          loading // Mostrar animación de carga si loading es verdadero
              ? Lottie.asset(
                  'assets/animation2.json',
                  width: 300,
                  height: 300,
                )
              : Container(
                  width: 300,
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.blue),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: temperatureData.mapIndexed((index, value) {
                            return FlSpot(index.toDouble(), value);
                          }).toList(),
                          isCurved: true,
                          color: Colors.red,
                          barWidth: 2,
                        ),
                        LineChartBarData(
                          spots: heartRateData.mapIndexed((index, value) {
                            return FlSpot(index.toDouble(), value);
                          }).toList(),
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 2,
                        ),
                        LineChartBarData(
                          spots: humidityData.mapIndexed((index, value) {
                            return FlSpot(index.toDouble(), value);
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 2,
                        ),
                      ],
                      minX: 0,
                      maxX: 9, // Mostrar solo los últimos 10 datos
                      minY: 70,
                      maxY: 100,
                    ),
                  ),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Lógica para guardar el documento
            },
            child: Text('Guardar Reporte'),
          ),
        ],
      ),
    );
  }
}

extension ListExtension<T> on List<T> {
  List<E> mapIndexed<E>(E Function(int index, T item) f) {
    var index = 0;
    return map((e) => f(index++, e)).toList();
  }
}
