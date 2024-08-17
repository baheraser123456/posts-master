import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nagdy_app/features/posts/data/models/api_model.dart';

class PostRemoteDataSource {
  Future<List<Apiposts>> fetchPosts(int limit, int skip) async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/posts?skip=$skip&limit=$limit'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<Apiposts> posts = [];
      for (var element in data['posts']) {
        posts.add(Apiposts.fromJson(element));
      }
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> deletePost(int postId) async {
    final response =
        await http.delete(Uri.parse('https://dummyjson.com/posts/$postId'));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  Future<void> upadatePost(Apiposts postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await http
        .patch(Uri.parse('https://dummyjson.com/posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to upadate post');
    }
  }

  Future<void> addedPost(Apiposts postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response =
        await http.post(Uri.parse('https://dummyjson.com/posts/'), body: body);
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to add post');
    }
  }
}
