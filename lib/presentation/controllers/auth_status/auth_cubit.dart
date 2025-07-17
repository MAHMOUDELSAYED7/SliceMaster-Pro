import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/service/cache/cache.dart';

part 'auth_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit() : super(LogoutInitial());

  void checkLoginStatus() {
    try {
      bool isUserLogin = CacheData.getData(key: 'isUserLogin') ?? false;
      if (isUserLogin) {
        emit(Login());
      } else {
        emit(Logout());
      }
    } catch (_) {
      emit(LogoutFailure());
    }
  }

  Future<void> logout() async {
    try {
      await CacheData.setData(key: 'isUserLogin', value: false);
      CacheData.deleteData(key: 'currentUser');
      emit(Logout());
    } catch (e) {
      emit(LogoutFailure());
    }
  }

  deactivate() {}
}
