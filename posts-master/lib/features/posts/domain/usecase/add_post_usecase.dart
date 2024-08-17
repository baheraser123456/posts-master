import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';
import 'package:nagdy_app/features/posts/domain/repositories/repostory.dart';

class AddPostUsecase {
  final PostRepository repository;

  AddPostUsecase({required this.repository});
  Future<void> call(DomainModel post) async {
    return await repository.addPost(post);
  }
}
