import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/constants/images.dart';
import '../../core/utils/constants/routes.dart';
import '../../core/utils/extension/extension.dart';
import '../controllers/auth_status/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  Future<void> _goToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => context.cubit<AuthStatusCubit>().checkLoginStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStatusCubit, AuthStatusState>(
      listener: (context, state) {
        if (state is Login) {
          Navigator.pushReplacementNamed(context, RouteManager.home);
        }
        if (state is Logout) {
          Navigator.pushReplacementNamed(context, RouteManager.login);
        }
      },
      child: Scaffold(
        body: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.width / 3,
                height: context.height / 3,
                child: SvgPicture.asset(
                  ImageManager.logoSVG,
                ),
              ),
              Image.asset(
                width: context.width / 3,
                height: context.height / 3,
                ImageManager.splashImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
