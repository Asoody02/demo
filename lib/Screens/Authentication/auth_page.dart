import 'package:demo_poll/Screens/Authentication/sign_up.dart';
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
              Text("Don't have an account?"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}