import 'package:dog_health/screens/ForgotPassword.dart';
import 'package:dog_health/screens/Menu.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.1)
            ],
            stops: [0.1, 0.9],
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
              SizedBox(height: 20),
              Text(
                'Bienvenido a',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'DOG-HEALTH',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                'Usuario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter your username'),
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
                      final ruta3 = MaterialPageRoute(builder: (context) {
                        return MenuScreen();
                      });
                      Navigator.push(context, ruta3);
                    },
                    child: Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background color
                      foregroundColor: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      final ruta4 = MaterialPageRoute(builder: (context) {
                        return const PasswordScreen();
                      });
                      Navigator.push(context, ruta4);
                    },
                    child: Text('Olvidaste la contraseña?'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(212, 247, 84, 72), // background color
                      foregroundColor: Colors.white, // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
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
