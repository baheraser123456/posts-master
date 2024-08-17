import 'package:get_it/get_it.dart';
import 'package:nagdy_app/features/posts/data/data_sources/post.dart';
import 'package:nagdy_app/features/posts/data/repositories_imp/repository_imp.dart';
import 'package:nagdy_app/features/posts/domain/repositories/repostory.dart';
import 'package:nagdy_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/delete_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/get_posts_usecase.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Usecases

  sl.registerLazySingleton<PostUsecase>(() => PostUsecase(repository: sl()));

// Repository

  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: sl()));

// DataSource

  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSource());

  // Cubit
  sl.registerLazySingleton<PostsCubit>(() => PostsCubit(
      PostUsecase(repository: sl()),
      DeletePostUsecase(repository: sl()),
      UpdatePostUsecase(repository: sl()),
      AddPostUsecase(repository: sl())));
}
