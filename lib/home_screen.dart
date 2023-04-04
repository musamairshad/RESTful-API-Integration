import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> postsList = [];
  Future<List<Post>> fetchPosts() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      postsList.clear();
      for (Map i in responseData) {
        postsList.add(Post.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("API Integration"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: fetchPosts(),
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: postsList.length,
                        itemBuilder: (ctx, i) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Title", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  Text(postsList[i].title.toString(),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("Description", style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                  Text(postsList[i].body.toString(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
        ],
      ),
    );
  }
}
