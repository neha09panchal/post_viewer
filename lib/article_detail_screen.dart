import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_viewer/post_model.dart';

import 'favourites_cubit.dart';
import 'favourites_state.dart';

class ArticleDetailScreen extends StatefulWidget {
  final PostModel post;

  const ArticleDetailScreen({super.key,
   required this.post });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4A90E2),
        title: const Text(
          "Posts Details",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              bool isFav = false;
              if (state is FavoritesUpdated) {
                isFav = state.favorites.contains(widget.post);
              }
              return IconButton(
                icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(widget.post);
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(widget.post.id.toString() ?? ''),
          Text(widget.post.title ?? ''),
          Text(widget.post.body ?? ''),
        ]
      ),
    ));
  }
}
