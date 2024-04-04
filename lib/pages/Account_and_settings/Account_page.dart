import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _username = 'Usuario';
  String _email = 'usuario@example.com';

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
              trailing: Icon(Icons.edit),
              onTap: () {
                _editUsername(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Correo electrónico'),
              subtitle: Text(_email),
              trailing: Icon(Icons.edit),
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
                _changePassword(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cerrar sesión'),
              trailing: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editUsername(BuildContext context) {
    // Implementa aquí la lógica para editar el nombre de usuario
  }

  void _editEmail(BuildContext context) {
    // Implementa aquí la lógica para editar el correo electrónico
  }

  void _changePassword(BuildContext context) {
    // Implementa aquí la lógica para cambiar la contraseña
  }

  void _logout(BuildContext context) {
    // Implementa aquí la lógica para cerrar sesión
  }
}
