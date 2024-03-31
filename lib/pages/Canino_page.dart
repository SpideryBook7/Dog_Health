import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_health/services/auth_canino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaninoList extends StatefulWidget {
  @override
  _CaninoListState createState() => _CaninoListState();
}

class _CaninoListState extends State<CaninoList> {
  late List<Map<String, dynamic>> _caninoData = [];

  @override
  void initState() {
    super.initState();
    _initializeCaninoData();
  }

  void _initializeCaninoData() async {
    List canino = await getCanino();
    setState(() {
      _caninoData = List<Map<String, dynamic>>.from(canino);
    });
  }

  void _guardarCambios() async {
    // Actualiza los documentos en Firestore con los nuevos valores de _caninoData
    for (int i = 0; i < _caninoData.length; i++) {
      await FirebaseFirestore.instance
          .collection('Registro_canino')
          .doc(
              'xpDb1VQJamMx9DIw2e8s') // Reemplaza 'documento_$i' con el ID correcto del documento
          .update(_caninoData[i]);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Datos guardados correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de tu canino'),
        backgroundColor: Color.fromARGB(190, 63, 168, 255).withOpacity(0.2),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _caninoData.length,
        itemBuilder: (context, index) {
          var canino = _caninoData[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: canino['Nombre'],
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Nombre'] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Nombre'),
                  ),
                  TextFormField(
                    initialValue: canino['Peso'].toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Peso'] = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Peso'),
                  ),
                  TextFormField(
                    initialValue: canino['Meses'].toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Meses'] = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Meses'),
                  ),
                  TextFormField(
                    initialValue: canino['Raza'].toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Raza'] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Raza'),
                  ),
                  TextFormField(
                    initialValue: canino['Estatura_cm'].toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Estatura_cm'] = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Estatura_cm'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guardarCambios,
        child: Icon(Icons.save),
      ),
    );
  }
}
