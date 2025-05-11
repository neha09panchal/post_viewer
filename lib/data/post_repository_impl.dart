import 'package:post_viewer/domain/model/post_model.dart';
import 'package:post_viewer/domain/post_repository.dart';
import 'package:dio/dio.dart';


class PostRepositoryImp implements PostRepository {
  final Dio _dio = Dio();

  @override
  Future<List<PostModel>> fetchPosts() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) { ///null handling for data
      final data = response.data as List;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}