import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  bool _privacyPolicyAccepted = false;
  bool _termsAndConditionsAccepted = false;
  String _selectedLanguage = 'Español'; // Idioma predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Apariencia',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            SwitchListTile(
              title: Text('Modo oscuro'),
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value!;
                });
              },
            ),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              'Privacidad y Condiciones',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            CheckboxListTile(
              title: Text('He leído y acepto el aviso de privacidad'),
              value: _privacyPolicyAccepted,
              onChanged: (value) {
                setState(() {
                  _privacyPolicyAccepted = value!;
                  if (_privacyPolicyAccepted) {
                    _showAcceptanceDialog(context, 'Aviso de Privacidad',
                        'Acepto el aviso de privacidad y estoy de acuerdo con sus términos y condiciones.',
                        () {
                      setState(() {
                        _privacyPolicyAccepted = true;
                      });
                    });
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('He leído y acepto los términos y condiciones'),
              value: _termsAndConditionsAccepted,
              onChanged: (value) {
                setState(() {
                  _termsAndConditionsAccepted = value!;
                  if (_termsAndConditionsAccepted) {
                    _showAcceptanceDialog(context, 'Términos y Condiciones',
                        'Acepto los términos y condiciones.', () {
                      setState(() {
                        _termsAndConditionsAccepted = true;
                      });
                    });
                  }
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Otras configuraciones',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            ListTile(
              title: Text('Notificaciones'),
              trailing: Icon(Icons.notifications),
              onTap: () {
                // Implementa aquí la lógica para gestionar las notificaciones
              },
            ),
            Divider(),
            ListTile(
              title: Text('Idioma'),
              trailing: Icon(Icons.language),
              onTap: () {
                _showLanguageDialog(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Cerrar sesión'),
              trailing: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Implementa aquí la lógica para cerrar sesión
              },
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar el diálogo de aceptación
  void _showAcceptanceDialog(
      BuildContext context, String title, String content, Function() onAccept) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(195, 219, 219, 219),
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onAccept();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar el diálogo de selección de idioma
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Idioma'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                _buildLanguageItem(context, 'Español'),
                _buildLanguageItem(context, 'Inglés'),
                _buildLanguageItem(context, 'Francés'),
                // Agrega más idiomas según sea necesario
              ],
            ),
          ),
        );
      },
    );
  }

  // Método auxiliar para crear un elemento de idioma en el diálogo
  Widget _buildLanguageItem(BuildContext context, String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.of(context).pop();
        // Implementa aquí la lógica para cambiar el idioma
      },
    );
  }
}
