import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signUp(email, password) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    try {
      await user.sendEmailVerification();
      return user;
    } catch (e) {
      print("An error occured while trying to send email        verification");
      print(e.message);
    }
  }

  Future<void> logIn(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  Future<String> getUid() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
