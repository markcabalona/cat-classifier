import 'package:cat_classifier/cubits/image_picker/image_picker_cubit.dart';
import 'package:cat_classifier/widgets/choose_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddNewImageFloatingButton extends StatelessWidget {
  const AddNewImageFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
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
      tooltip: "Pick Image",
      child: const Icon(Icons.add_a_photo_outlined),
    );
  }
}
