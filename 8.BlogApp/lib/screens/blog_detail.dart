import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blog.dart';

class BlogDetail extends StatefulWidget {
  const BlogDetail({
    Key? key,
    required this.blogId,
  }) : super(key: key);
  final String blogId;

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  List<Blog> blogList = [];
  Blog blog = Blog();

  fetchBlogs() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    final jsonData = json.decode(response.body);

    setState(() {
      blog = Blog.fromJson(jsonData);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(blog.title == null ? "Yükleniyor" : blog.title!)),
        body: blog.id == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 2,
                        child: Image.network(blog.thumbnail!),
                      ),
                      Text(blog.content!),
                      Text(blog.author!),
                    ],
                  ),
                ),
              ));
  }
}
