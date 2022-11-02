import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_http/models/post_model.dart';
import 'package:flutter_http/repository/network.dart';
import 'package:flutter_http/screens/single_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future getPost() async {
    try {
      final response = await ApiNetwork().fetchData("posts");
      // print(response.statusCode);
      List<Post> posts = [];
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        for (var post in body) {
          posts.add(Post.fromJson(post));
        }
      } else {
        throw Exception("error");
      }
      return posts;
    } on SocketException {
      // TODO: And snakbar to display the error "No Internet access"
      // print("no internet access on you device");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Post"),
      ),
      body: FutureBuilder(
        future: getPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async => await getPost(),
              child: PostList(
                index: snapshot.data,
              ),
            );
          } else if (snapshot.hasError) {
            const Center(
              child: Text("Could not Load data"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({super.key, required this.index});
  final List<Post> index;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: index.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SinglePostScreen(
                    title: index[i].title,
                    body: index[i].body,
                    id: index[i].id.toString(),
                  ),
                ),
              ),
              leading: Text(
                index[i].id.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(index[i].title),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const Divider(
              color: Colors.amber,
            )
          ],
        );
      },
    );
  }
}
