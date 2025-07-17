import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/source/database/hive_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final HiveDb _hiveDb = HiveDb();
  Future<void> register(String username, String password) async {
    try {
      final result = await _hiveDb.insertUser(username, password);

      if (result == 0) {
        emit(UsernameTaken());
      } else {
        emit(RegisterSuccess());
      }
    } catch (_) {
      emit(RegisterFailure());
    }
  }
}
