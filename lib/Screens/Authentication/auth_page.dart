import 'package:demo_poll/Screens/Authentication/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_poll/Providers/authentication_provider.dart';
import 'package:demo_poll/Screens/main_activity_page.dart';
import 'package:demo_poll/Utils/message.dart';
import 'package:demo_poll/Utils/router.dart';
import 'package:demo_poll/Styles/customTheme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox (
                height: 20
              ),
              ElevatedButton(
                onPressed: () async {
                  final userCredential = await Provider.of<AuthProvider>(context, listen: false)
                      .signInWithEmailPassword(_emailController.text, _passwordController.text);
                  if (userCredential != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainActivityPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Failed')),
                    );
                  }
                },
                child: Text('Sign In'),
              ),
              SizedBox(
                height:10
              ),
              RichText(
               text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Color(0xFF113143)), // This uses the default text style of the surrounding Text.
                  children: <TextSpan>[
                    TextSpan(text: "Don't have an account? "), 
                  TextSpan(
                    text: 'Sign up.', // Clickable part
                      style: TextStyle(color:  Color(0xFF5AC7F0), decoration: TextDecoration.underline), // Styling to indicate it's clickable.
                      recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                    ),
                  ],
                ),
              )


            //original sign UP button

              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const SignUpPage()),
              //     );
              //   },
              //   child: Text('Sign Up'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}