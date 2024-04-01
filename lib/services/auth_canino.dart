import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getCanino() async {
  List canino = [];
  CollectionReference collectionReferenceCanino =
      db.collection('Registro_canino');

  QuerySnapshot queryCanino = await collectionReferenceCanino.get();

  queryCanino.docs.forEach((documento) {
    canino.add(documento.data());
  });
  return canino;
}












//Bd firestoreDatabase reglas

// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /{document=**} {
//       allow read, write: if false;
//     }
//   }
// }