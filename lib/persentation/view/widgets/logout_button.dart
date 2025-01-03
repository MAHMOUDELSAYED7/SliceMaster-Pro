import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_master_pro/utils/extentions/extentions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/routes.dart';
import '../../../utils/helpers/my_snackbar.dart';
import '../../view_model/logout/logout_cubit.dart';

class LogoutButtton extends StatelessWidget {
  const LogoutButtton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: const EdgeInsets.only(top: 5),
      height: 34,
      waitDuration: const Duration(milliseconds: 350),
      exitDuration: const Duration(milliseconds: 150),
      showDuration: const Duration(milliseconds: 350),
      enableTapToDismiss: true,
      message: 'Logout',
      textStyle: context.textTheme.displaySmall
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 2.9.sp),
      decoration: BoxDecoration(
          color: ColorManager.red, borderRadius: BorderRadius.circular(4)),
      child: BlocListener<AuthStatusCubit, AuthStatusState>(
        listener: (context, state) {
          if (state is Logout) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteManager.login, (route) => false);
            customSnackBar(context, 'Logout Successfully!');
          }

          if (state is LogoutFailure) {
            customSnackBar(context, 'There was an error!');
          }
        },
        child: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => context.cubit<AuthStatusCubit>().logout(),
        ),
      ),
    );
  }
}
