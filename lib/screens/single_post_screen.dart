import 'package:flutter/material.dart';

class SinglePostScreen extends StatelessWidget {
  const SinglePostScreen({
    super.key,
    required this.title,
    required this.body,
    required this.id,
  });
  final String title, body, id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Number $id")),
      body: Card(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(title),
              Text(body),
            ],
          ),
        ),
      ),
    );
  }
}
