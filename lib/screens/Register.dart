import 'package:dog_health/screens/Menu.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.15),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.1)
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/Imagen4.png'),
                radius: 76.0,
              ),
              SizedBox(height: 20.0),
              Column(
                children: [
                  Text(
                    'Crea tu cuenta ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 78, 79)),
                  ),
                  Text(
                    'DOG-HEALTH',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 78, 79)),
                  ),
                  SizedBox(height: 40),
                ],
              ),
              Text(
                'Usuario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter your username'),
              ),
              SizedBox(height: 20),
              Text(
                'Correo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter your email'),
              ),
              SizedBox(height: 20),
              Text(
                'Contraseña',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                obscureText: !_showPassword,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final route = MaterialPageRoute(builder: (context) {
                        return MenuScreen();
                      });
                      Navigator.push(context, route);
                    },
                    child: Text('Ingresar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 1, 78, 79), // background color
                      foregroundColor: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
