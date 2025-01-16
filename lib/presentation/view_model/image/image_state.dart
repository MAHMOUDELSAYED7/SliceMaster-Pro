part of 'image_cubit.dart';

@immutable
abstract class PickImageState {}

class PickImageInitial extends PickImageState {}

class PickImageSuccess extends PickImageState {
  final File imagePath;

  PickImageSuccess({required this.imagePath});
}

class PickImageFailure extends PickImageState {
  final String? errMessage;

  PickImageFailure({this.errMessage});
}
