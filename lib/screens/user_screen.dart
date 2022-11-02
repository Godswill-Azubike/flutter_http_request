import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextStyle myStyle = const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w800,
    color: Colors.blue,
  );

  Future getUser() async {
    var response = await http.get(Uri.https("jsonplaceholder.typicode.com", 'users'));
    // print(response.body);
    var jsonData = jsonDecode(response.body);
    // print(jsonData);

    // print(jsonData[1]['website']);
    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username'], u['phone']);
      users.add(user);
    }

    // print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Http Users"),
      ),
      body: Card(
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Text("Loading ...", style: myStyle),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(snapshot.data[index].name, style: myStyle),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data[index].email),
                        Text(snapshot.data[index].phoneName),
                      ],
                    ),
                    trailing: Text(snapshot.data[index].userName),
                  );
                },
              );
            }
          },
        ),
      ),
      // body: Center(
      //   child: GestureDetector(
      //     onTap: () async => await getUser(),
      //     child: Text(
      //       "No User found",
      //       style: myStyle,
      //     ),
      //   ),
      // ),
    );
  }
}
