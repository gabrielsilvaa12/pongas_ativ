import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ------------------------------------------------
  // 1. Métodos de Autenticação Padrão (E-mail/Senha)
  // ------------------------------------------------

  // Método de Registro de Usuário com E-mail e Senha
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      // Retorna o código de erro para ser tratado na UI
      throw e.code;
    }
  }

  // Método de Login de Usuário com E-mail e Senha
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  // ------------------------------------------------
  // 2. Método de Autenticação com Google
  // ------------------------------------------------

  Future<User?> signInWithGoogle() async {
    try {
      // 1. Inicia o processo de login com o Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // O usuário cancelou o login
        return null;
      }

      // 2. Obtém os detalhes de autenticação da requisição
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Cria uma credencial do Firebase a partir do token do Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Faz o login no Firebase com a credencial
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      // Erros genéricos ou de rede
      throw 'google-sign-in-failed';
    }
  }
}
