import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RecordsScreen extends StatefulWidget {
  @override
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  // Datos iniciales de ejemplo
  List<double> temperatureData = [];
  List<double> heartRateData = [];
  List<double> humidityData = [];

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
          Container(
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
