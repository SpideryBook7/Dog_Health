import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<String, dynamic>>> getCanino() async {
  List<Map<String, dynamic>> canino = [];

  // Obtener el ID del usuario actualmente autenticado
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Realizar una consulta para obtener solo los documentos del usuario actual
  QuerySnapshot queryCanino = await FirebaseFirestore.instance
      .collection('Registro_canino')
      .where('uid', isEqualTo: userId) // Cambiar 'userId' por 'uid'
      .get();

  queryCanino.docs.forEach((documento) {
    canino.add(documento.data() as Map<String, dynamic>);
  });

  return canino;
}
