import 'package:flutter/material.dart';
import 'package:praktikum/profilePage.dart';
import 'package:praktikum/customAppBar.dart';
import 'package:praktikum/homePage.dart';
import 'package:praktikum/secondPage.dart';
import 'package:praktikum/postListScreen.dart';

class MainNavigator extends StatefulWidget {
  final int initialIndex;

  const MainNavigator({super.key, this.initialIndex = 0,});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SecondPage(),
    const ProfilePage(),
    const PostListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> pageTitles = <String>[
      'Halaman Utama',
      'Halaman Kedua',
      'Profil Pengguna',
      'Post CRUD',
    ];

    return Scaffold(
      appBar: CustomAppBar(
        titleText: pageTitles[_selectedIndex],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'SecondPage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Post CRUD',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
      ),
    );
  }
}
