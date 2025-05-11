import 'package:post_viewer/post_model.dart';

abstract class PostRepository{

  Future<List<PostModel>> fetchPosts();

}