import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_viewer/article_detail_screen.dart';
import 'package:post_viewer/posts_cubit.dart';

import 'favourites_cubit.dart';
import 'favourites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Posts")),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesUpdated && state.favorites.isNotEmpty) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final post = state.favorites[index];
                return Card(
                  shadowColor: Colors.grey,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                    title: Text(post.title ?? ''),
                    subtitle: Text(post.body ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                    onTap: () {
                      final route = MaterialPageRoute(builder: (context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (_) => PostsDetailsCubit()),
                          ],
                          child: ArticleDetailScreen(post: post),
                        );
                      });
                      Navigator.push(context, route);
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No favorite posts yet."));
          }
        },
      ),
    );
  }
}
