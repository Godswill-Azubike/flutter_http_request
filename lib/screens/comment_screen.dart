import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http/models/comment_model.dart';
import 'package:flutter_http/repository/network.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // late Future<List> futureComment;

  Future<List<Comment>> getComments() async {
    // final result = await http.get(
    //   Uri.parse("https://jsonplaceholder.typicode.com/comments"),
    // );
    final result = await ApiNetwork().fetchData("comments");

    // print(result.body);
    List<Comment> comments = [];

    if (result.statusCode == 200) {
      var jsonData = jsonDecode(result.body);
      // print(jsonData);
      for (var comment in jsonData) {
        var u = Comment.fromJson(comment);
        comments.add(u);
      }
      // print(comments);
      return comments;
      // print()
      // print(Comment.fromJson(jsonDecode(result.body)));
      // return Comment.fromJson(jsonData);
    } else {
      // print(2);
      throw Exception("could not fetch comment data");
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("http Comments"),
      ),
      body: Card(
        child: FutureBuilder(
          future: getComments(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index].name);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
