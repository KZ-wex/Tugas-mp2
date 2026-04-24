import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan1/pages/home_page.dart';
import 'firebase_options.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LinkedInApp());
}

class LinkedInApp extends StatefulWidget {
  const LinkedInApp({super.key});

  @override
  State<LinkedInApp> createState() => _LinkedInAppState();
}

class _LinkedInAppState extends State<LinkedInApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Beranda"),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profil"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
