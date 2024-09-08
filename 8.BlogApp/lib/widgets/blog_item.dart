import 'package:flutter/material.dart';

import 'package:miniblog/models/blog.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key, required this.blog}) : super(key: key);
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 4 / 2,
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  child: Image.network(blog.thumbnail!),
                ),
              ),
              ListTile(
                title: Text(blog.title!),
                subtitle: Text(blog.author!),
              )
            ],
          ),
        ));
  }
}
