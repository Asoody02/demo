import 'package:flutter/material.dart';
import 'package:demo_poll/Providers/authentication_provider.dart';
import 'package:demo_poll/Screens/Authentication/auth_page.dart';
import 'package:demo_poll/Screens/main_activity_page.dart';
import 'package:demo_poll/Screens/splash_screen.dart';
import 'package:demo_poll/Styles/colors.dart';
import 'package:demo_poll/Utils/message.dart';
import 'package:demo_poll/Utils/router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //top app bar
        surfaceTintColor: Color(0xFFC7E7F3),
        shadowColor: Colors.grey,
        backgroundColor: const Color(0xFF5AC7F0),
        centerTitle: true,
        title: Title(
          color: Colors.white,
          child: const Text(
            'Account Settings',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            )
          )
        )
      ),
        body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[ //notification tile here
          Text('Notifications'),
          SwitchListTile(
            title: Text('Enable  Notifications'),
            value: true,
            onChanged: (value) {
              setState(() {
                //something here
              });
            },
          ), //end notification tile
          Text('Account'),
            ListTile( //this is the feature to change the password. reroutes to login.originally, we had a seperate page that handled this.
            title: const Text('Change Password'),
            tileColor: Colors.white,
            shape: Border(
              top: BorderSide(
                color: const Color(0xFF113143),
                width: 1,
              ),
              bottom: BorderSide(
                color: const Color(0xFF113143),
                width: 1,
              ),
            ),
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
            trailing: Icon(Icons.arrow_right_outlined),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              AuthProvider().signOut().then((value) {
              // if (value == false) {
              //   error(context, message: "Please try again");
              // } else {
              nextPageOnly(context, const SplashScreen());
              // }
                });
              },
              child: const Text("Log Out"),
              ),
        //original code incase it messes up

        // GestureDetector(
        //   onTap: () {
        //     AuthProvider().signOut().then((value) {
        //       // if (value == false) {
        //       //   error(context, message: "Please try again");
        //       // } else {
        //       nextPageOnly(context, const SplashScreen());
        //       // }
        //     });
        //   },
          
        //   child: Container(
        //     height: 50,
        //     width: 100,
        //     decoration: BoxDecoration(
        //         color: AppColors.primaryColor,
        //         borderRadius: BorderRadius.circular(10)),
        //     alignment: Alignment.center,
        //     child: const Text("Log Out"),
        //   ),
        // )
        ]),
    );
  }
}
