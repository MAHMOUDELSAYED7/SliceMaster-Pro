import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/extension/extension.dart';
import '../../controllers/calc/calc_cubit.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.prices,
    required this.name,
  });

  final Map<PizzaSize, num> prices;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 10,
      right: 10,
      bottom: 15,
      child: SizedBox(
        child: Stack(
          children: [
            Positioned(
              right: 5,
              child: Text(
                name,
                style: context.textTheme.displaySmall?.copyWith(
                  color: ColorManager.white,
                  fontSize: 5.sp,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    const Shadow(
                      offset: Offset(1, -1),
                      color: ColorManager.black,
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: ShadowManager.shadow,
                color: ColorManager.darkGrey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: PizzaSize.values.reversed.map((size) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            prices[size]?.toStringAsFixed(1) ?? '',
                            style: context.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                              shadows: [
                                const Shadow(
                                  offset: Offset(1, -1),
                                  color: ColorManager.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            ' EGP',
                            style: context.textTheme.displaySmall?.copyWith(
                              fontSize: 3.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                              shadows: [
                                const Shadow(
                                  offset: Offset(1, -1),
                                  color: ColorManager.black,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
