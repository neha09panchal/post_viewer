import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_viewer/domain/model/post_model.dart';

import '../app_theme/app_theme.dart';
import 'favorites_screen/favourites_cubit.dart';
import 'favorites_screen/favourites_state.dart';

class ArticleDetailScreen extends StatefulWidget {
  final PostModel post;

  const ArticleDetailScreen({super.key, required this.post});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.lightPurple,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              "Posts Details",
              style: AppTheme.textStyle20700.copyWith(color: Colors.black),
            ),
          ),
          actions: [
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                bool isFav = false;
                if (state is FavoritesUpdated) {
                  isFav = state.favorites.contains(widget.post);
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(
                      isFav
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline_rounded,
                    ),
                    color: AppTheme.red,
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(
                        widget.post,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '#Post - ',
                    style: AppTheme.textStyle20700.copyWith(color: Colors.black),
                  ),
                  Text(
                    widget.post.id.toString(),
                    style: AppTheme.textStyle18400.copyWith(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Title:',
                style: AppTheme.textStyle20700.copyWith(color: Colors.black),
              ),
              Text(
                ' ${widget.post.title ?? ''}',
                style: AppTheme.textStyle18400.copyWith(color: Colors.black),
              ),

              SizedBox(height: 16.0),
              Text(
                'Description:',
                style: AppTheme.textStyle20700.copyWith(color: Colors.black),
              ),
              Text(
                widget.post.body ?? '',
                style: AppTheme.textStyle18400.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
