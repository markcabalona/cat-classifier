// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  final StateStatus status;
  final File? imageFile;
  final String? errorMessage;
  const ImagePickerState({
    this.status = StateStatus.initial,
    this.imageFile,
    this.errorMessage,
  });

  
  ImagePickerState copyWith({
    StateStatus? status,
    File? imageFile,
    String? errorMessage,
  }) {
    return ImagePickerState(
      status: status ?? this.status,
      imageFile: imageFile ?? this.imageFile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        if (imageFile != null) imageFile!,
        if (errorMessage != null) errorMessage!
      ];
}
