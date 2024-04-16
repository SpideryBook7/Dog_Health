import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';

class LogsScreen extends StatefulWidget {
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference();

  List<double> temperatureData = [];
  List<double> heartRateData = [];
  bool loading = true;
  Map<String, dynamic> caninoData = {}; // Datos del canino

  @override
  void initState() {
    super.initState();
    _listenToRealTimeData();
    _fetchCaninoData(); // Obtener datos del canino al inicio
  }

  void _listenToRealTimeData() {
    _databaseReference.child('historial').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        temperatureData.clear();
        heartRateData.clear();

        List<dynamic> temperatureValues = data['Temperatura'].values.toList();
        List<dynamic> heartRateValues = data['Pulso'].values.toList();

        for (int i = 0; i < temperatureValues.length; i++) {
          final temperature = temperatureValues[i] ?? 0.0;
          temperatureData.add(temperature.toDouble());
        }

        for (int i = 0; i < heartRateValues.length; i++) {
          final heartRate = heartRateValues[i] ?? 0.0;
          heartRateData.add(heartRate.toDouble());
        }

        setState(() {
          loading = false;
        });
      }
    });
  }

  Future<void> _fetchCaninoData() async {
    try {
      // Obtener el ID del usuario actualmente autenticado
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Obtener los datos del canino desde Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Registro_canino')
          .where('uid', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si se encuentra un documento, obtener los datos del canino
        caninoData = querySnapshot.docs.first.data() as Map<String, dynamic>;
      }
    } catch (error) {
      print('Error al obtener los datos del canino: $error');
    }
  }

  Future<void> _savePdf() async {
    final pdf = pdfLib.Document();

    // Definir estilos de texto
    final titleStyle =
    pdfLib.TextStyle(fontSize: 24, fontWeight: pdfLib.FontWeight.bold);
    final subtitleStyle =
    pdfLib.TextStyle(fontSize: 18, fontWeight: pdfLib.FontWeight.bold);
    final contentStyle = pdfLib.TextStyle(fontSize: 14);

    // Agregar el título
    pdf.addPage(
      pdfLib.Page(
        build: (context) {
          return pdfLib.Column(
            crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
            children: [
              pdfLib.Text(
                'Reporte de salud canina Dog Health',
                style: titleStyle,
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text(
                'Datos del usuario:',
                style: subtitleStyle,
              ),
              pdfLib.Text(
                'Nombre: ${user.displayName}',
                style: contentStyle,
              ),
              pdfLib.Text(
                'Email: ${user.email}',
                style: contentStyle,
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text(
                'Datos del canino:',
                style: subtitleStyle,
              ),
              pdfLib.Text(
                'Nombre: ${caninoData['Nombre']}',
                style: contentStyle,
              ),
              pdfLib.Text(
                'Peso: ${caninoData['Peso']}',
                style: contentStyle,
              ),
              pdfLib.Text(
                'Meses: ${caninoData['Meses']}',
                style: contentStyle,
              ),
              pdfLib.Text(
                'Raza: ${caninoData['Raza']}',
                style: contentStyle,
              ),
              pdfLib.Text(
                'Estatura_cm: ${caninoData['Estatura_cm']}',
                style: contentStyle,
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text(
                'Últimos registros guardados:',
                style: subtitleStyle,
              ),
              pdfLib.SizedBox(height: 10),
              pdfLib.Text(
                'Temperaturas:',
                style: contentStyle.copyWith(fontWeight: pdfLib.FontWeight.bold),
              ),
              for (int i = 0; i < temperatureData.length; i++)
                pdfLib.Text(
                  '${i + 1}. ${temperatureData[i]} °C',
                  style: contentStyle,
                ),
              pdfLib.SizedBox(height: 10),
              pdfLib.Text(
                'Pulsos:',
                style: contentStyle.copyWith(fontWeight: pdfLib.FontWeight.bold),
              ),
              for (int i = 0; i < heartRateData.length; i++)
                pdfLib.Text(
                  '${i + 1}. ${heartRateData[i]} ppm',
                  style: contentStyle,
                ),
            ],
          );
        },
      ),
    );

    // Guardar el archivo
    final String dir = (await getExternalStorageDirectory())!.path;
    final String path = '$dir/report.pdf';
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Mostrar notificación en la aplicación
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF guardado en: $path'),
        backgroundColor: Colors.teal,
        duration: Duration(seconds: 3),
      ),
    );
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
          loading
              ? CircularProgressIndicator() // Reemplaza Lottie por CircularProgressIndicator mientras se cargan los datos
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
                    spots: temperatureData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.red, // Cambiar el color directamente aquí
                    barWidth: 2,
                  ),
                  LineChartBarData(
                    spots: heartRateData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.green, // Cambiar el color directamente aquí
                    barWidth: 2,
                  ),
                ],
                minX: 0,
                maxX: temperatureData.length.toDouble() - 1, // Usar la longitud de los datos para maxX
                minY: (temperatureData + heartRateData)
                    .reduce((a, b) => a < b ? a : b) -
                    5,
                maxY: (temperatureData + heartRateData)
                    .reduce((a, b) => a > b ? a : b) +
                    5,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _savePdf,
            child: Text('Guardar Reporte'),
          ),
        ],
      ),
    );
  }
}
