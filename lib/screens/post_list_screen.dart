import 'package:flutter/material.dart';
import '../models/post.dart';
import '../repositories/post_repository.dart';
import '../utils/logger.dart';

class PostListScreen extends StatefulWidget {
  final PostRepository postRepository;

  const PostListScreen({super.key, required this.postRepository});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    AppLogger.info('Memuat PostListScreen');
    _postsFuture = widget.postRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Post (Latihan 1)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            AppLogger.error('Error memuat posts', snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada post.'));
          }

          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    child: Text('${post.id}'),
                  ),
                  title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        },
      ),
    );
  }
}