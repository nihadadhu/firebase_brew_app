import 'package:demo_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserId? _userFromFirebaseUSer(User? user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserId?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUSer);
  }

  //This function signs in anonymously using FirebaseAuth and returns the logged-in user.
  Future<UserId?> signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
