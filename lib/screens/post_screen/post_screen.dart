import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_viewer/app_theme/app_theme.dart';
import 'package:post_viewer/app_theme/image_constant.dart';
import 'package:post_viewer/app_theme/strings_contant.dart';
import 'package:post_viewer/screens/article_detail_screen.dart';
import 'package:post_viewer/screens/post_screen/posts_cubit.dart';
import 'package:post_viewer/screens/post_screen/posts_state.dart';

import '../favorites_screen/favorite_post_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late PostsDetailsCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<PostsDetailsCubit>(context);
    cubit.loadPosts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:  Image.asset(
            appLogo,
          ),
          backgroundColor: AppTheme.lightPurple,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              trendingPost,
              style: AppTheme.textStyle20700.copyWith(color: Colors.black),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(Icons.favorite_rounded, size: 30),
                color: AppTheme.red,
                onPressed: () {
                  final route = MaterialPageRoute(
                    builder: (context) {
                      return FavoritesScreen();
                    },
                  );
                  Navigator.push(context, route);
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<PostsDetailsCubit, PostsState>(
          builder: (BuildContext context, state) {
            if (state is PostsLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 2.0,
                        right: 2.0,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: searchHint,
                          hintStyle: AppTheme.textStyle16400.copyWith(
                            color: AppTheme.lightGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppTheme.darkGrey,
                          ),
                        ),
                        onChanged: (query) {
                          cubit.searchPosts(query);
                        },
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          cubit.loadPosts();
                        },
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                final route = MaterialPageRoute(
                                  builder: (context) {
                                    return ArticleDetailScreen(
                                      post: state.posts[index],
                                    );
                                  },
                                );
                                Navigator.push(context, route);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Card(
                                  shadowColor: Colors.grey,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ListTile(
                                    title: Text(state.posts[index].title ?? '',
                                    style: AppTheme.textStyle18700.copyWith(color: Colors.black),),
                                    subtitle: Text(
                                      state.posts[index].body ?? '',
                                      style: AppTheme.textStyle16400.copyWith(color: AppTheme.darkGrey,),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is PostsErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      errorImage,
                      width: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      errorText,
                      style: AppTheme.textStyle18700.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        cubit.loadPosts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.lightPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        retry,
                        style: AppTheme.textStyle16700.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppTheme.lightPurple,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
