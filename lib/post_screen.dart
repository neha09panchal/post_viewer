import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_viewer/article_detail_screen.dart';
import 'package:post_viewer/posts_cubit.dart';
import 'package:post_viewer/posts_state.dart';

import 'favorite_post_screen.dart';

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
        backgroundColor: Color(0xFF4A90E2),
        title: Center(
          child: const Text(
            "Trending Posts",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: "View Favorites",
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) {
                return FavoritesScreen();
              });
              Navigator.push(context, route);
            },
          )
        ],
      ),
          body: BlocBuilder <PostsDetailsCubit,PostsState>(
            builder: (BuildContext context, state) {
              if(state is PostsLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 2.0,right: 2.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by title or body',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (query) {
                            cubit.searchPosts(query);
                          },
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async{
                            cubit.loadPosts();
                          },
                          child: ListView.builder(
                            itemCount: state.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  final route = MaterialPageRoute(builder: (context) {
                                    return ArticleDetailScreen(
                                    post: state.posts[index],
                                                                      );
                                  });
                                  Navigator.push(context, route);
                                },
                                child: Card(
                                  shadowColor: Colors.grey,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: ListTile(
                                    title: Text(state.posts[index].title ?? ''),
                                    subtitle: Text(state.posts[index].body ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,),
                                  ),
                                ),
                              );
                            }),
                        ),
                      ),
                    ],
                  ),
                );
              }
              else if(state is PostsErrorState){
                return Container(color: Colors.grey,
                child: Text(state.message),);
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
          )
    ));
  }
}
