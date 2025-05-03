import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          leading: Text(post.id.toString()),
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
} 