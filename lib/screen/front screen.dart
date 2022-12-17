import 'package:flutter/material.dart';
import 'package:jit_gaye_hackathon/screen/discussion_room.dart';
import 'package:jit_gaye_hackathon/screen/image_send/image_send.dart';
import 'package:jit_gaye_hackathon/screen/latest_news.dart';
import 'package:jit_gaye_hackathon/screen/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const ImageSendOption(),
    const LatestNews(),
    const DiscussionRoom(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
              indicatorColor: Color.fromARGB(255, 117, 108, 108), height: 58),
          child: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            backgroundColor: Colors.brown[300],
            selectedIndex: _currentIndex,
            onDestinationSelected: (int newIndex) {
              setState(() {
                _currentIndex = newIndex;
              });
            },
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.newspaper),
                  icon: Icon(Icons.newspaper_outlined),
                  label: 'News'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.chat),
                  icon: Icon(Icons.chat_outlined),
                  label: 'Discussion'),
              NavigationDestination(
                  selectedIcon: Icon(Icons.person),
                  icon: Icon(Icons.person_outlined),
                  label: 'Profile'),
            ],
          )),
      body: Center(child: pages[_currentIndex]),
    );
  }
}
