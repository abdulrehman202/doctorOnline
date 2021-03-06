import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginController {
  FirebaseAuth _firebaseAuth;
  var _firebaseDatabase;
  FirebaseUser user;

  LoginController() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseDatabase = FirebaseDatabase.instance.reference();
  }

  Future<String> CheckSignIn(String _username, String _password) async {
    String login = ' ';
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: _username, password: _password);
      user = result.user;
      login = user.uid;
      print(login);
    } catch (e) {
      print(e.message);
    }
    return login;
  }

  Future<String> CreateNewUser(String _username, String _password) async {
    String login = ' ';
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _username, password: _password);
      user = result.user;
      login = user.uid;
      sendEmailVerification(user);
      print(login);
    } catch (e) {
      print(e.message);
    }
    return login;
  }

  Future<FirebaseUser> getCurrentUser() async {
    user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification(FirebaseUser user) async {
    print(user);
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  
}
