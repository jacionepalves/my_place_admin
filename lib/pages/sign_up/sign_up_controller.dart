import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_place_core/core/exceptions/email_em_uso_exception.dart';
import 'package:my_place_core/core/exceptions/email_invalido_exception.dart';
import 'package:my_place_core/core/exceptions/senha_fraca_exception.dart';

class SignUpController {
  String _nome = '';
  String _email = '';
  String _senha = '';
  bool _isLoading = false;

  final _firebaseAuth = FirebaseAuth.instance;
  final _userRef = FirebaseFirestore.instance.collection('usuarios');

  String validaSenhaRepetida(String senhaRepetida) {
    if (senhaRepetida.isEmpty) {
      return 'Campo obrigatório';
    } else if (senhaRepetida != _senha) {
      return 'Senhas devem ser iguais';
    }
    return null;
  }

  Future<void> criaUsuario() async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email,
        password: _senha,
      );
      await _userRef.doc(userCredential.user.uid).set({
        'nome': _nome,
        'email': _email,
        'tipo': 'ADMIN',
      });
    } on Exception catch (e) {
      if(e is FirebaseAuthException){
        if (e.code == 'invalid-email'){
          throw EmailInvalidoException();
        } else if(e.code == 'weak-password'){
          throw SenhaFracaException();
        } else if(e.code == 'email-already-in-use'){
          throw EmailEmUsoException();
        }   
      } else{
        rethrow;
      }
    }
  }

  void setNome(String nome) => _nome = nome;
  void setEmail(String email) => _email = email;
  void setSenha(String senha) => _senha = senha;
  void setIsLoading(bool isLoading) => _isLoading = isLoading;

  bool get isLoading => _isLoading;
}
