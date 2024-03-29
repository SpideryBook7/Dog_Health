// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   // Google_sign_in
//   signInWithGoogle() async {
//     //process sign in
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     //Obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     //create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     //finally
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
