import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramclon/tab_page.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Instagram Clon',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(50.0),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                _handleSignIn().then((user) {
                  print(user);
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount _googleSignInAccount =
    await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthentication =
    await _googleSignInAccount.authentication;
    final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
      idToken: _googleSignInAuthentication.idToken,
      accessToken: _googleSignInAuthentication.accessToken,
    );
    final AuthResult _authResult =
    await FirebaseAuth.instance.signInWithCredential(_authCredential);

    return _authResult.user;
  }
//  Future<FirebaseUser> _handleSingIn() async {
//    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//    FirebaseUser user = await _auth.signInWithCredential(
//        GoogleAuthProvider.getCredential(
//            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken).user;);
//    print("signed in " + user.displayName);
//    return user;
//  }
}
