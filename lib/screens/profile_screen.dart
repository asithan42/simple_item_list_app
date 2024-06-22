import 'package:flutter/material.dart';
import 'package:simple_app/constant/colors.dart';
import 'package:simple_app/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: textColor1,
            fontFamily: "Merriweather",
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Padding(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: Icon(
                  Icons.edit,
                  size: 40,
                  color: textColor1,
                ),
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assest/images/profilePic.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Asitha Nimalsiri',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Rubik",
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'asithan42@gmail.com',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Rubik",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //  login page code.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontFamily: "Rubik", fontSize: 20, color: textColor1),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: 5,
        color: secondaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: () => Navigator.pop(context, (const HomeScreen())),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.home,
          size: 50,
          color: textColor1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
