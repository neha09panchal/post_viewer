import 'package:post_viewer/post_model.dart';
import 'package:post_viewer/post_repository_impl.dart';
import 'package:post_viewer/posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostsDetailsCubit extends Cubit<PostsState> {
  PostsDetailsCubit() : super(PostsInitial());

  PostRepositoryImp repository = PostRepositoryImp();
  List<PostModel> _allPosts = [];

  ///add connectivity check as well

  Future<void> loadPosts() async  {
    emit(PostsLoading());
    try {
      final posts = await repository.fetchPosts();
      _allPosts = posts;
      emit(PostsLoadedState(posts: posts));
    } catch (e) {
      emit(PostsErrorState(e.toString()));
    }
  }


  void searchPosts(String query) {
    if (state is PostsLoadedState) {
      final filtered = _allPosts.where((post) {
        final q = query.toLowerCase();
        return post.title?.toLowerCase().contains(q) == true ||
            post.body?.toLowerCase().contains(q) == true;
      }).toList();

      emit(PostsLoadedState(posts: filtered));
    }
  }
}