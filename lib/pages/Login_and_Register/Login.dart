import 'package:dog_health/components/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dog_health/pages/Login_and_Register/ForgotPassword.dart';
import 'package:dog_health/auth/auth_google.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor llena ambos campos y no uses espacios.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor introduce un correo válido.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La contraseña debe tener mínimo 6 caracteres.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correo o contraseña incorrectos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide the system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Imagen3.png"), // Ruta de la imagen
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Logo
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/Imagen4.png'),
                    radius: 76.0,
                  ),
                  SizedBox(height: 20.0),

                  //hello again
                  Text(
                    'DOG HEALTH',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                      color: Colors.grey, // Color de la fuente
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '!Bienvenido!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey, // Color de la fuente
                    ),
                  ),
                  SizedBox(height: 50),

                  //email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white), // Color del texto
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white70), // Color del texto de sugerencia
                        fillColor: Colors.grey.withOpacity(0.5), // Color de fondo con opacidad
                        filled: true,
                        errorText: _emailController.text.isNotEmpty &&
                            !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                .hasMatch(_emailController.text.trim())
                            ? 'Enter a valid email'
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white), // Color del texto
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white70), // Color del texto de sugerencia
                        fillColor: Colors.grey.withOpacity(0.5), // Color de fondo con opacidad
                        filled: true,
                        errorText: _passwordController.text.isNotEmpty &&
                            _passwordController.text.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  //sign in btn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(12),

                        ),
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  //Google sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google btn
                      SquareTile(
                          onTap: () => signInWithGoogle(),
                          imagePath: 'assets/google.png')
                    ],
                  ),
                  SizedBox(height: 15),

                  //not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Colors.white, // Color de la fuente
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          '   Register now',
                          style: TextStyle(
                            color: Colors.deepPurple[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
