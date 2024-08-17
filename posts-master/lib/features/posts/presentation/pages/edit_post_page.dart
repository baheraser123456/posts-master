import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_cubit.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/button_widget.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/textfield_widget.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage(
      {super.key,
      required this.title,
      required this.description,
      required this.userId});
  final String title;
  final String description;
  final int userId;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late final TextEditingController descriptionn;
  late final TextEditingController title;

  @override
  void initState() {
    descriptionn = TextEditingController(text: widget.description);
    title = TextEditingController(text: widget.title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User ${widget.userId}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 20),
                //! title
                const Text('Title :',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 6),
                TextfieldWidget(controller: title),
                const SizedBox(height: 20),
                //! Description
                const Text('Description :',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 6),
                TextfieldWidget(controller: descriptionn, maxLines: 4),
                const SizedBox(height: 20),
                Divider(thickness: 1, color: Colors.grey.shade400),
                const SizedBox(
                  height: 18,
                ),
                //! Button
                ButtonWidget(
                  onPressed: () {
                    final updatedPost = DomainModel(
                      title: title.text,
                      body: descriptionn.text,
                      id: widget.userId,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orange,
                      content: const Text('Post Updated successfully'),
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ));
                    BlocProvider.of<PostsCubit>(context).update(updatedPost);

                    Navigator.of(context).pop();
                  },
                  text: 'Update',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
