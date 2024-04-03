import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_health/auth/auth_canino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future<void> _initializeCaninoData() async {
    try {
      List<Map<String, dynamic>>? canino = await getCanino();
      if (canino != null) {
        setState(() {
          _caninoData = canino;
        });
      }
    } catch (error) {
      print('Error al obtener los datos de Firestore: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener los datos de Firestore')),
      );
    }
  }

  void _guardarCambios() async {
    try {
      // Obtener el ID del usuario actualmente autenticado
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Obtener el ID del documento del canino para el usuario actual
      String caninoDocId = await FirebaseFirestore.instance
          .collection('Registro_canino')
          .where('uid', isEqualTo: userId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // Si hay un documento encontrado, devuelve el ID del primer documento
          return querySnapshot.docs.first.id;
        } else {
          // Si no se encuentra ningún documento, devuelve un ID vacío
          return '';
        }
      });

      if (caninoDocId.isNotEmpty) {
        // Actualiza el documento existente en Firestore
        await FirebaseFirestore.instance
            .collection('Registro_canino')
            .doc(caninoDocId)
            .update(_caninoData
                .first); // Actualiza con el primer (y único) conjunto de datos
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos guardados correctamente')),
        );
      } else {
        // Si no se encontró ningún documento, puedes manejar esta situación según sea necesario
        print('No se encontró ningún documento para el usuario actual.');
      }
    } catch (error) {
      print('Error al guardar los datos en Firestore: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar los datos en Firestore')),
      );
    }
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
                    initialValue: canino['Nombre'] ?? '',
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Nombre'] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Nombre'),
                  ),
                  TextFormField(
                    initialValue: (canino['Peso'] ?? 0).toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Peso'] = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Peso'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: (canino['Meses'] ?? 0).toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Meses'] = int.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Meses'),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    initialValue: canino['Raza'] ?? '',
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Raza'] = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Raza'),
                  ),
                  TextFormField(
                    initialValue: (canino['Estatura_cm'] ?? 0.0).toString(),
                    onChanged: (value) {
                      setState(() {
                        _caninoData[index]['Estatura_cm'] = double.parse(value);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Estatura_cm'),
                    keyboardType: TextInputType.number,
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
