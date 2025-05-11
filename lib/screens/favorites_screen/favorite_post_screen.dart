import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_viewer/app_theme/strings_contant.dart';
import 'package:post_viewer/screens/article_detail_screen.dart';
import 'package:post_viewer/screens/post_screen/posts_cubit.dart';

import '../../app_theme/app_theme.dart';
import 'favourites_cubit.dart';
import 'favourites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
              favPosts,
              style: AppTheme.textStyle20700.copyWith(color: Colors.black),
            ),
          ),
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesUpdated && state.favorites.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final post = state.favorites[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Card(
                        shadowColor: Colors.grey,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(
                            post.title ?? '',
                            style: AppTheme.textStyle18700.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            post.body ?? '',
                            style: AppTheme.textStyle16400.copyWith(
                              color: AppTheme.darkGrey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            final route = MaterialPageRoute(
                              builder: (context) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (_) => PostsDetailsCubit(),
                                    ),
                                  ],
                                  child: ArticleDetailScreen(post: post),
                                );
                              },
                            );
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return  Center(child: Text(noFavPosts,
                style: AppTheme.textStyle20700.copyWith(
                  color: Colors.black,
                ),
              ));
            }
          },
        ),
      ),
    );
  }
}
