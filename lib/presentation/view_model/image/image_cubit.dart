import 'dart:io' show File;

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit() : super(PickImageInitial());
  File? _pickedImage;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        _pickedImage = File(result.files.single.path!);
        return emit(PickImageSuccess(imagePath: _pickedImage!));
      }
      emit(PickImageFailure(errMessage: 'Pick Image Failure'));
    } catch (err) {
      emit(PickImageFailure(errMessage: err.toString()));
    }
  }
}
