import 'package:flutter/material.dart';

const Color _accentRed = Color(0xFFFF1919);

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.query_stats_outlined),
          activeIcon: Icon(Icons.query_stats),
          label: 'Estatísticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: _accentRed,
      unselectedItemColor: Colors.grey[700],
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: onItemTapped,
    );
  }
}
