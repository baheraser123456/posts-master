import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagdy_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/delete_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/update_post_usecase.dart';
import 'package:nagdy_app/features/posts/domain/usecase/get_posts_usecase.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_cubit.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_state.dart';
import 'package:nagdy_app/features/posts/presentation/pages/add_post_page.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/loading_widget.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/post_item_widget.dart';
import 'package:nagdy_app/injection_container.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(
          PostUsecase(repository: sl()),
          DeletePostUsecase(repository: sl()),
          UpdatePostUsecase(repository: sl()),
          AddPostUsecase(repository: sl()))
        ..fetchData(10, 0),
      child: const _TimelineBody(),
    );
  }
}

class _TimelineBody extends StatefulWidget {
  const _TimelineBody();

  @override
  State<_TimelineBody> createState() => _TimelineBodyState();
}

class _TimelineBodyState extends State<_TimelineBody> {
  final _scrollController = ScrollController();
  int skip = 10;

  @override
  initState() {
    _scrollController.addListener(_scrolllistner);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 10),
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  backgroundColor: Colors.orange,
                  tooltip: 'Add Review',
                  elevation: 4.0,
                  onPressed: () {
                    final postCubit = BlocProvider.of<PostsCubit>(context);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                              value: postCubit,
                              child: const AddpostPage(),
                            )));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 60,
                        child: Image.asset(
                          'images/icon.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        itemCount: state.posts.length + 1,
                        itemBuilder: (context, index) {
                          if (index < state.posts.length) {
                            return PostItemWidget(
                              title: state.posts[index].title.toString(),
                              description: state.posts[index].body.toString(),
                              userId: state.posts[index].id.toString(),
                              removeId: state.posts[index].id ?? 0,
                              updateId: state.posts[index].id ?? 0,
                            );
                          } else {
                            return const Center(
                                child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Future<void> _scrolllistner() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {});
      await BlocProvider.of<PostsCubit>(context).fetchData(10, skip);
      skip += 10;

      setState(() {});
    }
  }
}
