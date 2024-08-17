import 'package:nagdy_app/features/posts/data/models/api_model.dart';
import 'package:nagdy_app/features/posts/domain/repositories/repostory.dart';

class PostUsecase {
  final PostRepository repository;

  PostUsecase({required this.repository});

  Future<List<Apiposts>> call(int limit, int skip) async {
    try {
      return await repository.getCarts(limit, skip);
    } catch (e) {
      rethrow;
    }
  }
}
