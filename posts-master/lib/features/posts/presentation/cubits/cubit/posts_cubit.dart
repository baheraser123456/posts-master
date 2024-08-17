import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagdy_app/features/posts/data/models/api_model.dart';
import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';
import 'package:nagdy_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/delete_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/get_posts_usecase.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostUsecase postUsecase;
  final DeletePostUsecase deletePostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final AddPostUsecase addPostUsecase;
  List<Apiposts> newPost = [];
  PostsCubit(this.postUsecase, this.deletePostUsecase, this.updatePostUsecase,
      this.addPostUsecase)
      : super(PostsInitial());
//! get the posts
  Future<void> fetchData(int limit, int skip) async {
    try {
      final response = await postUsecase.call(limit, skip);
      newPost.addAll(response);
      if (response.isNotEmpty) {
        emit(PostsLoaded(newPost));
      }
    } catch (e) {
      emit(const PostsError('no data found'));
    }
  }

//! Delete the posts
  void delete(int id) async {
    try {
      // ignore: unused_local_variable
      final data = await deletePostUsecase.call(id);
      deletePost(id);
    } catch (e) {
      if (e is FormatException) {
        emit(const PostsError('no data found'));
      }
    }
  }

  void deletePost(int id) {
    final newState = state as PostsLoaded;
    final newListOfPost = newState.posts;

    final index = newListOfPost.indexWhere((element) => element.id == id);
    newListOfPost.removeAt(index);
    emit(PostsLoaded(newState.posts));
  }

//! Update the posts
  void update(DomainModel updatedPost) async {
    try {
      await updatePostUsecase.call(updatedPost);
      updatePost(updatedPost);
    } catch (e) {
      emit(const PostsError('error occurred while updating'));
    }
  }

  void updatePost(DomainModel updatedPost) {
    final newState = state as PostsLoaded;
    final updatedList = newState.posts.map((post) {
      if (post.id == updatedPost.id) {
        return Apiposts(
          id: updatedPost.id,
          title: updatedPost.title,
          body: updatedPost.body,
        );
      } else {
        return post;
      }
    }).toList();
    newPost = updatedList;
    emit(PostsLoaded(updatedList));
  }

  //! add posts
  void addPost(DomainModel createPost) {
    final newState = state as PostsLoaded;
    final newListOfPost = newState.posts;
    final newPostToAdd = Apiposts(
      id: createPost.id,
      title: createPost.title,
      body: createPost.body,
    );
    newListOfPost.insert(0, newPostToAdd);
    emit(PostsLoaded(newListOfPost));
  }
}
