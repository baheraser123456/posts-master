import 'package:nagdy_app/features/posts/data/models/api_model.dart';
import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';

abstract class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Apiposts> posts;

  const PostsLoaded(this.posts);
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);
}

class Postsadded extends PostsState {
  final List<Apiposts> products;

  const Postsadded(this.products);
}

class DeletePost extends PostsState {
  final int postId;

  DeletePost({required this.postId});
}

class UpdatePost extends PostsState {
  final DomainModel post;

  UpdatePost({required this.post});
}
