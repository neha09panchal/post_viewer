import 'package:post_viewer/domain/model/post_model.dart';

abstract class PostRepository{

  Future<List<PostModel>> fetchPosts();

}