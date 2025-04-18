import 'package:flutter/material.dart';

import '../category/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    PlaceholderWidget(label: "Home"),
    PlaceholderWidget(label: "Shop"),
    CategoryScreen(),
    PlaceholderWidget(label: "Cart"),
    PlaceholderWidget(label: "Profile"),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.store,
    Icons.category,
    Icons.shopping_cart,
    Icons.person,
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
