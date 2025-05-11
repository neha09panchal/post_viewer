import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:post_viewer/domain/model/post_model.dart';

import 'favourites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    _loadFavorites();
  }

  late Box<PostModel> _favoritesBox;

  Future<void> _loadFavorites() async {
    _favoritesBox = Hive.box<PostModel>('favorites');
    emit(FavoritesUpdated(_favoritesBox.values.toList()));
  }

  void toggleFavorite(PostModel post) {
    if (_favoritesBox.containsKey(post.id)) {
      _favoritesBox.delete(post.id);
    } else {
      _favoritesBox.put(post.id, post);
    }
    emit(FavoritesUpdated(_favoritesBox.values.toList()));
  }

  bool isFavorite(PostModel post) {
    return _favoritesBox.containsKey(post.id);
  }
}
