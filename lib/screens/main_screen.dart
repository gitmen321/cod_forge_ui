import 'package:flutter/material.dart';

import 'category/category_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    PlaceholderWidget(label: "Home"),
    PlaceholderWidget(label: "Shop"),
    CategoryScreen(),
    PlaceholderWidget(label: "Cart"),
    PlaceholderWidget(label: "Profile"),
  ];

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.favorite_outline_outlined,
    Icons.category_outlined,
    Icons.shopping_cart_outlined,
    Icons.person_2_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 52, 140, 54),
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: List.generate(_icons.length, (index) {
          final isSelected = index == _currentIndex;
          final icon = Icon(
            _icons[index],
            color: isSelected ? Colors.white : Colors.black,
            size: 24,
          );

          return BottomNavigationBarItem(
            icon: isSelected
                ? CircleAvatar(
                    backgroundColor:
                        const Color.fromARGB(255, 52, 140, 54),
                    child: icon,
                  )
                : icon,
            label: '',
          );
        }),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String label;
  const PlaceholderWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label Screen',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
