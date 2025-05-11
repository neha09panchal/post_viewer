import 'package:post_viewer/domain/model/post_model.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<PostModel> posts;


  PostsLoadedState({required this.posts});
}

class PostsErrorState extends PostsState {
  final String message;

  PostsErrorState(this.message);
}