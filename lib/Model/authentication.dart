import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe/Model/user.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RecipeUser? _castUser(User? user) {
    return user == null
        ? null
        : RecipeUser(email: user.email, name: user.displayName);
  }

  // authentication change stream
  Stream<RecipeUser?> get user {
    return _auth.userChanges().map(_castUser);
  }

  // sign in anonymously
  // Future<void> signInAnonymously() async {
  //   try {
  //     final User? user = (await _auth.signInAnonymously()).user;

  //     print("Signed in anonymously as User with ${user?.uid}");
  //     // Scaffold.of(context).showSnackBar(
  //     //   SnackBar(
  //     //     content: Text('Signed in Anonymously as user ${user.uid}'),
  //     //   ),
  //     // );
  //   } catch (e) {
  //     // Scaffold.of(context).showSnackBar(
  //     //   const SnackBar(
  //     //     content: Text('Failed to sign in Anonymously'),
  //     //   ),
  //     // );
  //     print("Faild to sign in anonymously");
  //   }
  // }

  Future signInGuest() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      User? user = userCred.user;
      // print(user);
      return user?.uid;
    } catch (err) {
      print(err.toString());
    }
    return null;
  }


  Future signOut() async {
    await _auth.signOut();
  }

  Future<bool> updateName(String name) async{
    try{
      await _auth.currentUser?.updateDisplayName(name);
      return true;
    }
    catch(err) {
      print(err.toString());
      return false;
    }
  }

  Future<RecipeUser?> signInEmail(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCred.user;
      return _castUser(user);
    } catch (err) {
      print(err.toString());
    }

    return null;
  }

  Future<RecipeUser?> signUpEmail(String name, String email, String password) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCred.user;
      await _auth.currentUser?.updateDisplayName(name);
      // TODO: Delete the print statement
      print("Name: ${user?.displayName}");
      return _castUser(user);
    } catch (err) {
      print(err.toString());
      if (err.toString().trim() == "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
        throw("سبق استخدام البريد الإلكتروني المدخل");
      }
    }

    return null;
  }
}
