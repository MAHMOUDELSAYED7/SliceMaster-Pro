import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/view/archive.dart';
import '../../presentation/view/home.dart';
import '../../presentation/view/login.dart';
import '../../presentation/view/pizza_management.dart';
import '../../presentation/view/register.dart';
import '../../presentation/view/splash.dart';
import '../../presentation/view_model/archive/archive_cubit.dart';
import '../../presentation/view_model/calc/calc_cubit.dart';
import '../../presentation/view_model/excel/excel_cubit.dart';
import '../../presentation/view_model/image/image_cubit.dart';
import '../../presentation/view_model/invoice/invoice_cubit.dart';
import '../../presentation/view_model/login/login_cubit.dart';
import '../../presentation/view_model/auth_status/auth_cubit.dart';
import '../../presentation/view_model/register/register_cubit.dart';
import '../../presentation/view_model/repository/pizza_cubit.dart';
import '../utils/constants/routes.dart';
import 'page_transition.dart';

abstract class AppRouter {
  const AppRouter._();
  static final _pizzasRepositoryCubit = PizzasRepositoryCubit();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.initialRoute:
        return PageTransitionManager.fadeTransition(
          BlocProvider(
            create: (context) => AuthStatusCubit(),
            child: const SplashScreen(),
          ),
        );

      case RouteManager.login:
        return PageTransitionManager.fadeTransition(BlocProvider(
          create: (context) => LoginCubit(),
          child: const LoginScreen(),
        ));

      case RouteManager.register:
        return PageTransitionManager.fadeTransition(BlocProvider(
          create: (context) => RegisterCubit(),
          child: const RegisterScreen(),
        ));

      case RouteManager.home:
        return PageTransitionManager.fadeTransition(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => InvoiceCubit(),
            ),
            BlocProvider.value(value: _pizzasRepositoryCubit..loadUserPizzas()),
            BlocProvider(
              create: (context) => AuthStatusCubit(),
            ),
            BlocProvider(
              create: (context) => CalculatorCubit(),
            ),
          ],
          child: const HomeScreen(),
        ));
      case RouteManager.pizzaManagement:
        return PageTransitionManager.fadeTransition(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _pizzasRepositoryCubit),
              BlocProvider(
                create: (context) => PickImageCubit(),
              ),
            ],
            child: const PizzaManagementScreen(),
          ),
        );
      case RouteManager.archive:
        return PageTransitionManager.fadeTransition(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => ArchiveCubit()..fetchInvoices()),
              BlocProvider(create: (context) => ExcelCubit()),
            ],
            child: const ArchiveScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
