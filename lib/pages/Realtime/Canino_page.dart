// canino_list.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_health/auth/auth_canino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          SnackBar(
            content: Text(
              'Datos guardados correctamente',
              style: TextStyle(
                  color: Colors.white), // Cambiando el color del texto
            ),
            backgroundColor: Color.fromARGB(
                191, 132, 255, 136), // Cambiando el color de fondo
            duration: Duration(seconds: 2), // Duración de la notificación
            behavior: SnackBarBehavior.floating, // Estilo flotante
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Ajustando el borde
            ),
          ),
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

  //body canino
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _caninoData.length,
              itemBuilder: (context, index) {
                var canino = _caninoData[index];
                return Card(
                  elevation: 3, // Adding elevation
                  margin: EdgeInsets.all(9),
                  // Adding margin
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
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
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(), // Adding border
                          ),
                          style: myTextStyle,
                        ),
                        SizedBox(
                            height: 13), // Adding space between text fields
                        TextFormField(
                          initialValue: (canino['Peso'] ?? 0).toString(),
                          onChanged: (value) {
                            setState(() {
                              _caninoData[index]['Peso'] = double.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Peso',
                            border: OutlineInputBorder(), // Adding border
                          ),
                          style: myTextStyle,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                            height: 13), // Adding space between text fields
                        TextFormField(
                          initialValue: (canino['Meses'] ?? 0).toString(),
                          onChanged: (value) {
                            setState(() {
                              _caninoData[index]['Meses'] = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Meses',
                            border: OutlineInputBorder(), // Adding border
                          ),
                          style: myTextStyle,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                            height: 13), // Adding space between text fields
                        TextFormField(
                          initialValue: canino['Raza'] ?? '',
                          onChanged: (value) {
                            setState(() {
                              _caninoData[index]['Raza'] = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Raza',
                            border: OutlineInputBorder(), // Adding border
                          ),
                          style: myTextStyle,
                        ),
                        SizedBox(
                            height: 13), // Adding space between text fields
                        TextFormField(
                          initialValue:
                              (canino['Estatura_cm'] ?? 0.0).toString(),
                          onChanged: (value) {
                            setState(() {
                              _caninoData[index]['Estatura_cm'] =
                                  double.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Estatura_cm',
                            border: OutlineInputBorder(), // Adding border
                          ),
                          style: myTextStyle,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false, // Make the navigation fixed
      floatingActionButton: FloatingActionButton(
        onPressed: _guardarCambios,
        child: Icon(Icons.save),
      ),
    );
  }

  final myTextStyle = GoogleFonts.getFont(
    'Bebas Neue',
    fontWeight: FontWeight.bold,
    fontSize: 19,
    color: Color.fromARGB(255, 47, 146, 185),
  );
}
