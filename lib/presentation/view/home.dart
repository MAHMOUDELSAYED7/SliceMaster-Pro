import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/constants/routes.dart';
import '../../core/utils/extension/extension.dart';
import '../../core/widgets/icon_button_tooltip.dart';
import '../../core/widgets/logout_button.dart';
import '../../data/model/pizza.dart';
import '../view_model/calc/calc_cubit.dart';
import '../view_model/repository/pizza_cubit.dart';
import 'widgets/action_card.dart';
import 'widgets/invoice_card.dart';
import 'widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = context.cubit<CalculatorCubit>();
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          ImageManager.logoSVG,
          width: context.width * 0.15,
        ),
        actions: [
          SizedBox(width: 5.w),
          IconButtonWithTooltip(
            onPressed: () =>
                Navigator.pushNamed(context, RouteManager.pizzaManagement),
            iconData: Icons.local_pizza,
            message: 'Pizza Management',
          ),
          SizedBox(width: 5.w),
          IconButtonWithTooltip(
            onPressed: () => Navigator.pushNamed(context, RouteManager.archive),
            message: 'Archive',
            iconData: Icons.inventory,
          ),
          SizedBox(width: 5.w),
          const LogoutButton(),
          SizedBox(width: 5.w),
        ],
      ),
      body: BlocBuilder<PizzasRepositoryCubit, List<PizzaModel>>(
        builder: (context, userPizzaList) {
          return Stack(
            children: [
              Positioned(
                bottom: -35,
                right: 10,
                child: Image.asset(
                  ImageManager.splashImage,
                  width: context.width * 0.2,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        left: context.width / 25,
                        right: context.width / 25,
                        top: 32.h,
                        bottom: 50,
                      ),
                      itemCount: userPizzaList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        final pizza = userPizzaList[index];
                        final prices = {
                          PizzaSize.s:
                              calculator.getPizzaPrice(pizza, PizzaSize.s),
                          PizzaSize.m:
                              calculator.getPizzaPrice(pizza, PizzaSize.m),
                          PizzaSize.l:
                              calculator.getPizzaPrice(pizza, PizzaSize.l),
                        };

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: ShadowManager.shadow,
                                color: ColorManager.offWhite2.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: context.width * 0.15,
                              height: context.width * 0.15,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 20.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(pizza.image!)),
                                ),
                              ),
                            ),
                            ItemCard(
                              prices: prices,
                              name: pizza.name,
                            ),
                            ActionCard(
                              pizza: pizza,
                              onDecrement: () => calculator.decrement(pizza),
                              onIncrement: () => calculator.increment(pizza),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const InvoiceCard(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
