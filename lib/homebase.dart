import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nsbm/pages/Login/loginpage.dart';
import 'package:nsbm/pages/mainPages/homepage.dart';
import 'package:nsbm/pages/mainPages/notificataionpage.dart';
import 'package:nsbm/pages/startingactivity.dart';

class HomeBase extends StatefulWidget {
  const HomeBase({super.key});

  @override
  State<HomeBase> createState() => _HomeBaseState();
}

int ACTIVENUMBER = 0;
// List pages = [];
List pages = [
  HomePage(),
  HomePage(),
  NotificationPage(
    notif: "Notifications",
  ),
  HomePage(),
];

class _HomeBaseState extends State<HomeBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[ACTIVENUMBER],
      bottomNavigationBar: GNav(
          onTabChange: (value) {
            setState(() {
              ACTIVENUMBER = value;
            });
            if (ACTIVENUMBER == 3) {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => StartingActivity()));
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.people,
              text: 'Location Share',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Notifications',
            ),
            GButton(
              icon: Icons.logout,
              text: 'Logout',
            ),
          ]),
    );
  }
}
