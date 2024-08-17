import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nagdy_app/features/posts/domain/model/domin_model.dart';
import 'package:nagdy_app/features/posts/presentation/cubits/cubit/posts_cubit.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/button_widget.dart';
import 'package:nagdy_app/features/posts/presentation/widgets/textfield_widget.dart';

class AddpostPage extends StatefulWidget {
  const AddpostPage({super.key});

  @override
  State<AddpostPage> createState() => _AddpostPageState();
}

class _AddpostPageState extends State<AddpostPage> {
  final TextEditingController postUserId = TextEditingController();
  final TextEditingController postTitle = TextEditingController();

  final TextEditingController postDescribtion = TextEditingController();
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
                //! UserId
                const Text('User ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 6),
                TextfieldWidget(controller: postUserId, inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Allow only numbers
                ]),
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
                TextfieldWidget(controller: postTitle),
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
                TextfieldWidget(controller: postDescribtion, maxLines: 4),
                const SizedBox(height: 20),
                Divider(thickness: 1, color: Colors.grey.shade400),
                const SizedBox(
                  height: 18,
                ),
                //! Button
                ButtonWidget(
                  onPressed: () {
                    // to convert the controller from string to int
                    final id = int.tryParse(postUserId.text) ?? 0;
                    final aaddPost = DomainModel(
                      title: postTitle.text,
                      body: postDescribtion.text,
                      id: id,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.orange,
                      content: const Text('Post added successfully'),
                      action: SnackBarAction(
                        label: 'Undo',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ));
                    BlocProvider.of<PostsCubit>(context).addPost(aaddPost);

                    Navigator.of(context).pop();
                  },
                  text: 'Add Post',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
