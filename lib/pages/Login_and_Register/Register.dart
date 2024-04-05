// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Cloud Firestore
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Welcome_and_Nab_bar/navigation.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future<void> addUserToCollection(String uid, String email) async {
    await usersCollection.add({
      'uid': uid,
      'email': email,
      'created_at': Timestamp.fromDate(DateTime.now()),
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        if (userCredential.user != null) {
          // Agrega el usuario a Firestore
          await FirebaseFirestore.instance
              .collection('Usuarios')
              .doc(userCredential
                  .user!.uid) // Utiliza el UID del usuario como ID de documento
              .set({
            'email': userCredential.user!.email,
          });

          // Agrega el documento a la colección "Registro_canino"
          await FirebaseFirestore.instance.collection('Registro_canino').add({
            'uid': userCredential.user!.uid,
            'Nombre': '',
            'Peso': 0,
            'Meses': 0,
            'Raza': '',
            'Estatura_cm': 0.0,
          });
        }

        // Navega a la página del menú
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('La contraseña proporcionada es demasiado débil.');
        } else if (e.code == 'email-already-in-use') {
          print('La cuenta ya existe para ese correo electrónico.');
        } else {
          print('Error: ${e.code}');
        }
      } catch (e) {
        print('Error al registrar al usuario: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide the system UI elements
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 50),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
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
                      fillColor: Colors.grey[200],
                      filled: true,
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
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //confirm password Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: _confirmpasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Confirm password',
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //sign in btn
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I am a member?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        '   Login now',
                        style: TextStyle(
                          color: Colors.blue,
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
    );
  }
}
