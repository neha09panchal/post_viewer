import 'package:post_viewer/domain/model/post_model.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<PostModel> favorites;
  FavoritesUpdated(this.favorites);
}
