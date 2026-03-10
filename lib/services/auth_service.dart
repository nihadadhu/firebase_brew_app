import 'package:firebase_auth/firebase_auth.dart';
import '../model/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  // Convert Firebase user to our app user
  UserId? _userFromFirebaseUser(User? user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserId?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Register with email & password
  Future<UserId?> registerWithEmailAndPass(
  String username,
  String email,
  String password,
) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    if (user != null) {
      await user.updateDisplayName(username);
    }

    return _userFromFirebaseUser(user);
  } catch (e) {
    print(e);
    return null;
  }
}

  // Sign in with email & password
  Future<UserId?> signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    await _auth.signOut();
  }
}