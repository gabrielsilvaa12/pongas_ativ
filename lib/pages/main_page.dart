import 'package:flutter/material.dart';
import 'package:pongas_ativ/componentes/header.dart';
import 'package:pongas_ativ/componentes/nav_bar.dart';
import 'package:pongas_ativ/pages/history_page.dart';
import 'package:pongas_ativ/pages/home_page.dart';
import 'package:pongas_ativ/pages/stats_page.dart';
import 'package:pongas_ativ/pages/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    // Índice 0: home
    HomePage(),
    // Índice 1: Buscar
    StatsPage(),
    // Índice 3: Histórico
    HistoryPage(),
    // Índice 4: Perfil
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Header(),

          Expanded(child: _pages[_currentIndex]),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
