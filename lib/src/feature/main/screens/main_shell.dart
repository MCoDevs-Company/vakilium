import 'package:flutter/material.dart';

class MainShell extends StatefulWidget {
  const MainShell({required this.child, super.key});
  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  Widget build(BuildContext context) => Scaffold(body: widget.child, bottomNavigationBar: _buildBottomNavigationBar());

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
}
