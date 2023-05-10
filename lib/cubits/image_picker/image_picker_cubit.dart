import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cat_classifier/core/enums/state_status.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(const ImagePickerState());
  final ImagePicker picker = ImagePicker();

  void chooseImage({required ImageSource source}) async {
    if (source == ImageSource.camera) {
      if ((await Permission.camera.status) != PermissionStatus.granted) {
        await Permission.camera.request();
      }
    }

    if ((await Permission.camera.status) != PermissionStatus.granted) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          errorMessage: 'Camera permission was denied.',
        ),
      );
      return;
    }

    final XFile? pickedFile = await picker.pickImage(
      source: source,
    );

    if (pickedFile == null) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          errorMessage: 'No image was selected.',
        ),
      );
      return;
    }
    File imageFile = File(pickedFile.path);

    emit(
      state.copyWith(
        status: StateStatus.loaded,
        imageFile: imageFile,
      ),
    );
  }
}
