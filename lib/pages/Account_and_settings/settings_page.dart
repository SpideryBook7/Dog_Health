import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Login_and_Register/Login.dart';

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
  void initState() {
    super.initState();
    _loadSettingsFromFirestore();
  }

  // Método para cargar la configuración guardada desde Firestore
  void _loadSettingsFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Usuarios').doc(user.uid).get();
      if (snapshot.exists) {
        setState(() {
          _privacyPolicyAccepted = snapshot.data()?['Politicas_privacidad'] ?? false;
          _termsAndConditionsAccepted = snapshot.data()?['Terminos_y_condiciones'] ?? false;
        });
      }
    }
  }

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
              onChanged: (value) async {
                setState(() {
                  _privacyPolicyAccepted = value!;
                });
                // Actualizar en Firestore
                _updateFirestorePrivacyPolicy(value!);
                // Mostrar el diálogo de aceptación con las políticas de privacidad
                if (value) {
                  _showAcceptanceDialog(
                    context,
                    'Politicas de Privacidad',
                    privacyPolicyText,
                        () {},
                  );
                }
              },
            ),
            // Terminos y condiciones
            CheckboxListTile(
              title: Text('He leído y acepto los términos y condiciones'),
              value: _termsAndConditionsAccepted,
              onChanged: (value) async {
                setState(() {
                  _termsAndConditionsAccepted = value!;
                });
                // Actualizar en Firestore
                _updateFirestoreTermsAndConditions(value!);
                // Mostrar el diálogo de aceptación con los términos y condiciones
                if (value) {
                  _showAcceptanceDialog(
                    context,
                    'Términos y Condiciones',
                    termsAndConditionsText,
                        () {},
                  );
                }
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

          ],
        ),
      ),
    );
  }

  // Método para mostrar el diálogo de aceptación
  void _showAcceptanceDialog(
      BuildContext context,
      String title,
      String content,
      Function() onAccept,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(content),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onAccept();
                        },
                        child: Text('Aceptar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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

  // Método para actualizar el estado de las políticas de privacidad en Firestore
  void _updateFirestorePrivacyPolicy(bool value) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Usuarios').doc(user.uid).update({'Politicas_privacidad': value});
    }
  }

  // Método para actualizar el estado de los términos y condiciones en Firestore
  void _updateFirestoreTermsAndConditions(bool value) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Usuarios').doc(user.uid).update({'Terminos_y_condiciones': value});
    }
  }

  final String termsAndConditionsText = '''
Términos y Condiciones de Dog Health.

Al acceder y utilizar Dog Health, aceptas estar sujeto a estos términos y condiciones. Si no estás de acuerdo con alguno de estos términos, no podrás acceder a la aplicación.

1. Uso de la Aplicación
Al utilizar Dog Health, aceptas utilizarla únicamente para fines legales y de acuerdo con estos términos y condiciones. No debes utilizar la aplicación de ninguna manera que pueda dañarla o impedir su acceso a otros usuarios.

2. Contenido
El contenido proporcionado en Dog Health es solo para fines informativos y de entretenimiento. No garantizamos la precisión, integridad o actualidad de este contenido.

3. Propiedad Intelectual
Todos los derechos de propiedad intelectual en Dog Health y su contenido pertenecen a sus respectivos propietarios. No tienes derecho a utilizar este contenido de ninguna manera que no esté autorizada por el propietario.

4. Enlaces Externos
Dog Health puede contener enlaces a sitios web externos que no son propiedad ni están controlados por nosotros. No tenemos control ni asumimos responsabilidad por el contenido, las políticas de privacidad o las prácticas de cualquier sitio web de terceros.

5. Cambios en los Términos y Condiciones
Nos reservamos el derecho de modificar estos términos y condiciones en cualquier momento. Se te notificará cualquier cambio mediante la publicación de los términos y condiciones actualizados en Dog Health. El uso continuado de la aplicación después de la publicación de los cambios constituirá tu aceptación de dichos cambios.

6. Contáctanos
Si tienes alguna pregunta sobre estos términos y condiciones, contáctanos en DogHealth69@gmail.com.
''';

  final String privacyPolicyText = '''
Política de Privacidad de Dog Health.

Esta Política de Privacidad describe cómo Dog Health ("nosotros", "nuestro" o "nos") recopila, utiliza y comparte información personal cuando utilizas nuestra aplicación móvil Dog Health (en adelante, la "Aplicación").

1. Información que Recopilamos
Información Personal que Proporcionas
Cuando utilizas nuestra Aplicación, podemos recopilar la información personal que nos proporcionas, como tu nombre de usuario, dirección de correo electrónico y otra información que nos facilites directamente.

Información Recopilada Automáticamente
Además, cuando utilizas la Aplicación, podemos recopilar cierta información de forma automática, incluidos, entre otros, el tipo de dispositivo que utilizas, la identificación única de tu dispositivo, la dirección IP de tu dispositivo, tu sistema operativo, el tipo de navegador móvil que utilizas y la forma en que interactúas con la Aplicación.

2. Cómo Utilizamos la Información
Utilizamos la información que recopilamos para:

- Proporcionarte y mantener nuestra Aplicación.
- Mejorar, personalizar y expandir nuestra Aplicación.
- Entender y analizar cómo utilizas nuestra Aplicación.
- Desarrollar nuevos productos, servicios, características y funcionalidades.
- Comunicarnos contigo, ya sea directamente o a través de uno de nuestros socios, incluidos fines promocionales y de marketing.
- Encontrar y prevenir fraudes.

3. Compartir Información
Podemos compartir tu información personal con terceros para ayudarnos a utilizar tu información personal, como se describe anteriormente. Por ejemplo, podemos utilizar proveedores de servicios externos para facilitar nuestra Aplicación, realizar servicios relacionados con la Aplicación o ayudarnos a analizar cómo se utiliza nuestra Aplicación.

4. Seguridad
La seguridad de tu información personal es importante para nosotros, pero recuerda que ningún método de transmisión por Internet o método de almacenamiento electrónico es 100% seguro. Si bien nos esforzamos por utilizar medios comercialmente aceptables para proteger tu información personal, no podemos garantizar su seguridad absoluta.

5. Enlaces a Terceros
Nuestra Aplicación puede contener enlaces a sitios web de terceros. Si haces clic en un enlace de un tercero, serás dirigido a ese sitio web. Te recomendamos revisar la Política de Privacidad de cada sitio que visites.

6. Cambios en esta Política de Privacidad
Podemos actualizar nuestra Política de Privacidad de vez en cuando. Te notificaremos de cualquier cambio publicando la nueva Política de Privacidad en esta página.

7. Contáctanos
Si tienes alguna pregunta o sugerencia acerca de nuestra Política de Privacidad, no dudes en contactarnos en DogHealth69@gmail.com.
''';
}
