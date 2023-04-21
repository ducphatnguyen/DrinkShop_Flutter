import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _bottomNavItem(Icons.home, 'Home', '/'),
        _bottomNavItem(Icons.favorite, 'Yêu thích', '/'),
        _bottomNavItem(Icons.shopping_cart, 'Cart', '/cart'),
        _bottomNavItem(Icons.person, 'Tôi', '/profile'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 151, 56, 56),
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem _bottomNavItem(IconData icon, String label, String route) {
    return BottomNavigationBarItem(
      icon: Icon(icon,color: Colors.red,),
      label: label,
    );
  }

  void _onItemTapped(int index) {
  setState(() { 
    _selectedIndex = index;
  });
  String route = _getRoute(index);
  if (index == 0) {
    // Chuyển đến tuyến đường mới và xóa đi tất cả các tuyến đường cũ khỏi ngăn xếp điều hướng.
    Navigator.of(context).pushReplacementNamed(route);
  } else {
    Navigator.of(context).pushNamed(route);
  }
}

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/wishlist';  
      case 2:
        return '/cart';
      case 3:
        return '/profile';
      default:
        return '/';
    }
  }
}
