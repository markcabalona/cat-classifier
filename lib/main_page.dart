// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cat_classifier/core/constants/constants.dart';
import 'package:cat_classifier/core/enums/state_status.dart';
import 'package:cat_classifier/cubits/cat_classifier/cat_classifier_cubit.dart';
import 'package:cat_classifier/cubits/image_picker/image_picker_cubit.dart';
import 'package:cat_classifier/widgets/choose_image_dialog.dart';
import 'package:cat_classifier/widgets/floating_action_button.dart';
import 'package:cat_classifier/widgets/results_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: Image.asset('assets/images/app-icon.png'),
            title: const Text(
              'Cat Breed Classifier',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          body: const HomePage(),
          floatingActionButton: state.status == StateStatus.loaded
              ? const AddNewImageFloatingButton()
              : null,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<ImagePickerCubit, ImagePickerState>(
              buildWhen: (previous, current) {
                return current.status == StateStatus.loaded;
              },
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, .25),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: state.status != StateStatus.loaded
                      ? Column(
                          children: [
                            Text(
                              'Tap the cat to add an image',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        )
                      : const SizedBox(),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 2.5),
                  ]),
              constraints: const BoxConstraints(
                maxHeight: 350,
                maxWidth: 300,
                minHeight: 250,
                minWidth: 200,
              ),
              clipBehavior: Clip.hardEdge,
              child: GestureDetector(
                onTap: () {
                  showDialog<ImageSource>(
                    context: context,
                    builder: (context) {
                      return const ChooseImageDialog();
                    },
                  ).then((value) {
                    if (value != null) {
                      BlocProvider.of<ImagePickerCubit>(context).chooseImage(
                        source: value,
                      );
                    }
                  });
                },
                child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
                    listener: (context, state) {
                  if (state.status == StateStatus.loaded) {
                    BlocProvider.of<CatClassifierCubit>(context)
                        .imageClassification(state.imageFile!);
                  }
                }, builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, .25),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: state.status != StateStatus.loaded
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                appIconPath,
                                height: 200,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15.0, left: 30),
                                child: Icon(
                                  Icons.add,
                                  size: 48,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          )
                        : Image.file(
                            state.imageFile!,
                            fit: BoxFit.fitWidth,
                          ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            const ResultsWidget(),
          ],
        ),
      ),
    );
  }
}
