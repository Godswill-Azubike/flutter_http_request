import 'package:flutter/material.dart';
import 'package:flutter_http/screens/comment_screen.dart';
import 'package:flutter_http/screens/post_screen.dart';
import 'package:flutter_http/screens/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle myStyle = const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserScreen(),
                ),
              );
            },
            child: const Text('All Users'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CommentScreen(),
              ),
            ),
            child: const Text('All Comments'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostScreen(),
              ),
            ),
            child: const Text('Post'),
          )
        ],
      )),
    );
  }
}
