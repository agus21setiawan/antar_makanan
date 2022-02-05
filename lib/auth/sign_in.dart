import 'package:antar_makanan/home_utama.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);

      return user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/bgr1.jpg')),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 380,
                width: 380,
                color: Color(0xff91672c),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Sign in to continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Anterin',
                      style: TextStyle(
                          fontSize: 50,
                          color: Color(0xffe9e2ce),
                          shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.white,
                              offset: Offset(3, 3),
                            )
                          ]),
                    ),
                    Column(
                      children: [
                        SignInButton(
                          Buttons.Facebook,
                          text: "Sign in with Facebook",
                          onPressed: () {},
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign up with Google",
                          onPressed: () {
                            _googleSignUp().then(
                              (value) => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomeUtama(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'By signig inyou are agreening to our',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Terms and pripacy Policy',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
