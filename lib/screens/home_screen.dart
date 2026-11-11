import 'package:flutter/material.dart';
import '../config/dependency_injector.dart';
import 'post_list_screen.dart';
import 'user_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userRepo = DependencyInjector.of(context).userRepository;
    final postRepo = DependencyInjector.of(context).postRepository;

    final pages = [
      UserListScreen(repository: userRepo),
      PostListScreen(postRepository: postRepo),
    ];
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Posts'),
        ],
      ),
    );
  }
}