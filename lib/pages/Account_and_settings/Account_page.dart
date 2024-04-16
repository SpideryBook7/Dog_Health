import 'package:dog_health/components/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String _username = 'Usuario';
  String _email = 'usuario@example.com';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  // Método para obtener la información del usuario actual
  void _getUserInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = user.email ?? 'usuario@example.com';
      });
      _getFirestoreUserInfo(user.uid);
    }
  }

  // Método para obtener el nombre de usuario desde Firestore
  void _getFirestoreUserInfo(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Usuarios').doc(uid).get();
    if (snapshot.exists) {
      setState(() {
        _username = snapshot.data()?['Usuario'] ?? 'Usuario';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Información de la cuenta',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              title: Text('Nombre de usuario'),
              subtitle: Text(_username),
              trailing: Icon(Icons.edit_attributes_rounded),
              onTap: () {
                _editUsername(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Correo electrónico'),
              subtitle: Text(_email),
              trailing: Icon(Icons.vpn_lock_outlined),
              onTap: () {
                _editEmail(context);
              },
            ),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Opciones de la cuenta',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              title: Text('Cambiar contraseña'),
              trailing: Icon(Icons.lock),
              onTap: () {
                _confirmResetPassword(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cerrar sesión'),
              trailing: Icon(Icons.logout),
              onTap: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editUsername(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Nombre de Usuario'),
          content: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Ingrese su nuevo nombre de usuario',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String newUsername = _usernameController.text.trim();
                if (newUsername.isNotEmpty) {
                  _updateUsername(newUsername);
                  Navigator.of(context).pop();
                } else {
                  // Manejar el caso en el que el campo esté vacío
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _updateUsername(String newUsername) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Actualizar el nombre de usuario en Firebase Auth
        await user.updateDisplayName(newUsername);

        // Actualizar el nombre de usuario en Firestore
        await FirebaseFirestore.instance
            .collection('Usuarios')
            .doc(user.uid)
            .update({'Usuario': newUsername});

        setState(() {
          _username = newUsername;
        });

        // Mostrar un mensaje de éxito o alguna otra acción
      } catch (e) {
        // Manejar cualquier error que pueda ocurrir
      }
    }
  }

  void _editEmail(BuildContext context) {
    // Implementa aquí la lógica para editar el correo electrónico
  }

  void _confirmResetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Cambio de Contraseña'),
          content: Text(
              '¿Estás seguro de cambiar tu contraseña? Se enviará un correo electrónico de confirmación a $_email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _sendPasswordResetEmail(_email);
                Navigator.of(context).pop();
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  void _sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Mostrar un mensaje de éxito o alguna otra acción
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
    }
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}
