import 'package:america_app/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential?> signUp(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'name': name,
          'createdAt': Timestamp.now(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Já existe uma conta para este e-mail.');
      }
      throw Exception('Erro de registro: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado: ${e.toString()}');
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Tratar erros específicos do Firebase Auth
      if (e.code == 'user-not-found') {
        throw Exception('Nenhum usuário encontrado para este e-mail.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Senha incorreta.');
      }
      throw Exception('Erro de login: ${e.message}');
    } catch (e) {
      throw Exception('Ocorreu um erro inesperado: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(uid)
          .get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        return UserProfile(
          uid: data['uuid'] ?? '',
          email: data['email'] ?? '',
          roles: List<String>.from(data['roles'] as List),
          createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      print('Erro ao buscar perfil do usuário: $e');
      return null;
    }
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
