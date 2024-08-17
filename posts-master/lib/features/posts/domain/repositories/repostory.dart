import 'package:nagdy_app/features/posts/data/models/api_model.dart';
import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';

abstract class PostRepository {
  Future<List<Apiposts>> getCarts(int limit, int skip);
  Future<void> deletePost(int id);
  Future<void> updatePost(DomainModel post);
  Future<void> addPost(DomainModel post);
}
