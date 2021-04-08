import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter_app3/api_response.dart';

String firebaseUserUid;

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error */ ..|.. /* $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email, password: senha);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error */ ..|.. /* $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> cadastrar(String nome,String email, String senha) async {
    try {
      // Login no Firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email:email, password: senha);
      final FirebaseUser fUser = result.user;

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;
      userUpdateInfo.photoUrl = "https://encrypted-tbn0.gstatic.com/images?q=t"
          "bn:ANd9GcRg1ONHoTo7u9daU0Y7JS5zfaE9kcvlMEhpfezog9IUqgb5KkUixhkAi4ZYpusRKhK45PQ&usqp=CAU";
      fUser.updateProfile(userUpdateInfo);

      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error */ ..|.. /* $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

  }
}