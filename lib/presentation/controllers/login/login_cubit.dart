import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/service/cache/cache.dart';
import '../../../data/source/database/hive_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final HiveDb _hiveDb = HiveDb();

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final user = await _hiveDb.getUser(username, password);

      if (user != null) {
        await CacheData.setData(key: 'isUserLogin', value: true);
        await CacheData.setData(key: 'currentUser', value: username);
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (_) {
      emit(LoginFailure());
    }
  }
}
