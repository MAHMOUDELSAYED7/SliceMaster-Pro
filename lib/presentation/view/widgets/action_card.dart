import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/extension/extension.dart';
import '../../../data/model/pizza.dart';
import '../../controllers/calc/calc_cubit.dart';

class ActionCard extends StatefulWidget {
  const ActionCard({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.pizza,
  });

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final PizzaModel pizza;

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorCubit, Map<PizzaModel, Map<PizzaSize, int>>>(
      builder: (context, state) {
        final selectedSize = context.read<CalculatorCubit>().getPizzaSize(widget.pizza);

        return Positioned(
          bottom: 10,
          right: 15,
          left: 15,
          child: Container(
            height: 15.sp,
            decoration: BoxDecoration(
              color: ColorManager.darkGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPizzaSizeSelectors(selectedSize),
                IconButton(
                  onPressed: widget.onIncrement,
                  icon: Icon(Icons.add, size: 7.sp),
                ),
                IconButton(
                  onPressed: widget.onDecrement,
                  icon: Icon(Icons.remove, size: 7.sp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPizzaSizeSelector(int index, PizzaSize selectedSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              PizzaSize.values[index].name.toUpperCase(),
              style: context.textTheme.displaySmall
                  ?.copyWith(color: ColorManager.white),
            ),
            Radio<PizzaSize>(
              activeColor: ColorManager.white,
              value: PizzaSize.values[index],
              groupValue: selectedSize,
              onChanged: (PizzaSize? value) {
                if (value != null) {
                  context.read<CalculatorCubit>().setPizzaSize(widget.pizza, value);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPizzaSizeSelectors(PizzaSize selectedSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        PizzaSize.values.length,
        (index) => _buildPizzaSizeSelector(index, selectedSize),
      ),
    );
  }
}
