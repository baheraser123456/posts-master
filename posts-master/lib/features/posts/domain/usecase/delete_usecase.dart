import 'package:nagdy_app/features/posts/domain/repositories/repostory.dart';

class DeletePostUsecase {
  final PostRepository repository;

  DeletePostUsecase({required this.repository});
  Future<void> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
