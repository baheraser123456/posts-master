import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';
import 'package:nagdy_app/features/posts/domain/repositories/repostory.dart';

class UpdatePostUsecase {
  final PostRepository repository;

  UpdatePostUsecase({required this.repository});
  Future<void> call(DomainModel post) async {
    return await repository.updatePost(post);
  }
}
