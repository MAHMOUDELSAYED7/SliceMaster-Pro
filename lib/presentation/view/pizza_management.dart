import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/extension/extension.dart';
import '../../core/utils/helpers/my_snackbar.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/icon_button_tooltip.dart';
import '../../data/model/pizza.dart';
import '../../presentation/view_model/repository/pizza_cubit.dart';
import '../view_model/image/image_cubit.dart';

class PizzaManagementScreen extends StatefulWidget {
  const PizzaManagementScreen({super.key});

  @override
  State<PizzaManagementScreen> createState() => _PizzaManagementScreenState();
}

class _PizzaManagementScreenState extends State<PizzaManagementScreen> {
  File? _pickedImage;
  late GlobalKey<FormState> _addNewItemFormKey;
  late GlobalKey<FormState> _updatePriceFormKey;
  @override
  void initState() {
    _addNewItemFormKey = GlobalKey<FormState>();
    _updatePriceFormKey = GlobalKey<FormState>();
    super.initState();
  }

  num? _smallPrice;
  num? _mediumPrice;
  num? _largePrice;
  String? _pizzaName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          ImageManager.logoSVG,
          width: context.width * 0.15,
        ),
        actions: [
          IconButtonWithTooltip(
            onPressed: () => Navigator.pop(context),
            iconData: Icons.arrow_back,
            message: 'Back',
          ),
          SizedBox(width: 5.w),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: -35,
            right: 10,
            child: Image.asset(
              ImageManager.splashImage,
              width: context.width * 0.2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: context.width / 2.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<PickImageCubit, PickImageState>(
                      listener: (context, state) {
                        if (state is PickImageSuccess) {
                          _pickedImage = state.imagePath;
                        }
                        if (state is PickImageFailure) {
                          customSnackBar(context, state.errMessage);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                const WidgetStatePropertyAll(EdgeInsets.zero),
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            overlayColor: const WidgetStatePropertyAll(
                                ColorManager.offWhite2),
                            backgroundColor: WidgetStatePropertyAll(
                                ColorManager.offWhite2.withOpacity(0.9)),
                            fixedSize: WidgetStatePropertyAll(
                              Size(context.width / 3, context.height / 2),
                            ),
                          ),
                          child: _pickedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.file(
                                    width: double.infinity,
                                    height: double.infinity,
                                    _pickedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 20.sp,
                                  color: ColorManager.darkGrey,
                                ),
                          onPressed: () =>
                              context.cubit<PickImageCubit>().pickImage(),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _buildPizzaForm(context)
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(right: context.width * 0.04, bottom: 20),
              width: context.width / 3,
              height: context.height / 1.2,
              decoration: BoxDecoration(
                color: ColorManager.offWhite2.withOpacity(0.6),
                boxShadow: ShadowManager.shadow,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: _buildPizzaList(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPizzaForm(BuildContext context) {
    return Form(
      key: _addNewItemFormKey,
      child: SizedBox(
        width: context.width * 0.25,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MyTextFormField(
                    validateWithoutText: true,
                    hintText: 'Pizza Name',
                    onSaved: (value) => _pizzaName = value!,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    validateWithoutText: true,
                    keyboardType: TextInputType.number,
                    hintText: 'Small Price',
                    onSaved: (value) => _smallPrice = num.parse(value!),
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: MyTextFormField(
                    validateWithoutText: true,
                    keyboardType: TextInputType.number,
                    hintText: 'Medium Price',
                    onSaved: (value) => _mediumPrice = num.parse(value!),
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(
                  child: MyTextFormField(
                    validateWithoutText: true,
                    keyboardType: TextInputType.number,
                    hintText: 'Large Price',
                    onSaved: (value) => _largePrice = num.parse(value!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MyElevatedButton(
              title: 'Add Pizza',
              onPressed: () {
                if (_addNewItemFormKey.currentState!.validate() &&
                    _pickedImage != null) {
                  _addNewItemFormKey.currentState?.save();
                  final image = _pickedImage!.path;
                  context.cubit<PizzasRepositoryCubit>().addUserPizza(
                        name: _pizzaName!,
                        largePrice: _largePrice!,
                        mediumPrice: _mediumPrice!,
                        smallPrice: _smallPrice!,
                        image: image,
                      );
                  _clearForm();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPizzaList(BuildContext context) {
    return BlocBuilder<PizzasRepositoryCubit, List<PizzaModel>>(
      builder: (context, pizzas) {
        return ListView.separated(
            itemBuilder: (context, index) => _buildPizzaItem(pizzas[index]),
            separatorBuilder: (context, index) => const Divider(
                  thickness: 3,
                  color: ColorManager.offWhite2,
                  endIndent: 10,
                  indent: 10,
                ),
            itemCount: pizzas.length);
      },
    );
  }

  Widget _buildPizzaItem(PizzaModel pizza) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: FileImage(
                  File(pizza.image!),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizza.name,
                  style: context.textTheme.bodyLarge,
                ),
                SizedBox(height: 1.h),
                Text(
                  '${pizza.smallPrice} , ${pizza.mediumPrice} , ${pizza.largePrice} EGP',
                  style: context.textTheme.displayMedium,
                ),
              ],
            ),
          ),
          SizedBox(width: 3.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                style: context.theme.iconButtonTheme.style,
                icon: Icon(
                  Icons.edit,
                  color: context.iconTheme.color,
                ),
                onPressed: () => _showUpdatePriceDialog(pizza),
              ),
              SizedBox(width: 5.w),
              IconButton(
                style: context.theme.iconButtonTheme.style,
                icon: Icon(
                  Icons.delete,
                  color: context.iconTheme.color,
                ),
                onPressed: () => _showConfirmationDialog(pizza),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showUpdatePriceDialog(PizzaModel pizza) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Form(
          key: _updatePriceFormKey,
          child: AlertDialog(
            backgroundColor: ColorManager.white,
            title: Text(
              'Update Price for ${pizza.name}',
              style: context.textTheme.bodyLarge,
            ),
            content: SizedBox(
              width: context.width * 0.2,
              child: Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      validateWithoutText: true,
                      keyboardType: TextInputType.number,
                      hintText: 'Small Price',
                      onSaved: (value) => _smallPrice = num.parse(value!),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: MyTextFormField(
                      validateWithoutText: true,
                      keyboardType: TextInputType.number,
                      hintText: 'Medium Price',
                      onSaved: (value) => _mediumPrice = num.parse(value!),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: MyTextFormField(
                      validateWithoutText: true,
                      keyboardType: TextInputType.number,
                      hintText: 'Large Price',
                      onSaved: (value) => _largePrice = num.parse(value!),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size(context.width * 0.09, 34.h)),
                  backgroundColor:
                      const WidgetStatePropertyAll(ColorManager.red),
                  overlayColor: WidgetStatePropertyAll(
                      ColorManager.white.withOpacity(0.2)),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  'Cancel',
                  style: context.textTheme.displayMedium
                      ?.copyWith(color: ColorManager.white),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                      WidgetStatePropertyAll(Size(context.width * 0.09, 34.h)),
                  backgroundColor:
                      const WidgetStatePropertyAll(ColorManager.correct),
                  overlayColor: WidgetStatePropertyAll(
                      ColorManager.white.withOpacity(0.2)),
                ),
                onPressed: () {
                  if (_updatePriceFormKey.currentState!.validate()) {
                    _updatePriceFormKey.currentState?.save();
                    context.cubit<PizzasRepositoryCubit>().updatePizzaPrice(
                          pizza: pizza,
                          newLargePrice: _largePrice!,
                          newMediumPrice: _mediumPrice!,
                          newSmallPrice: _smallPrice!,
                        );
                    _clearForm();
                    Navigator.of(dialogContext).pop();
                  }
                },
                child: Text(
                  'Update',
                  style: context.textTheme.displayMedium
                      ?.copyWith(color: ColorManager.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(PizzaModel pizza) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: ColorManager.white,
          title: Text(
            'Remove ${pizza.name}?',
            style: context.textTheme.bodyLarge,
          ),
          content: Text(
            'Are you sure you want to remove this pizza?',
            style: context.textTheme.displayMedium,
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    WidgetStatePropertyAll(Size(context.width * 0.09, 34.h)),
                backgroundColor:
                    const WidgetStatePropertyAll(ColorManager.correct),
                overlayColor:
                    WidgetStatePropertyAll(ColorManager.white.withOpacity(0.2)),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: context.textTheme.displayMedium
                    ?.copyWith(color: ColorManager.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize:
                    WidgetStatePropertyAll(Size(context.width * 0.09, 34.h)),
                backgroundColor: const WidgetStatePropertyAll(ColorManager.red),
                overlayColor:
                    WidgetStatePropertyAll(ColorManager.white.withOpacity(0.2)),
              ),
              onPressed: () {
                context
                    .cubit<PizzasRepositoryCubit>()
                    .removeUserPizza(pizzaName: pizza.name);

                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Remove',
                style: context.textTheme.displayMedium
                    ?.copyWith(color: ColorManager.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _addNewItemFormKey.currentState?.reset();
    setState(() {
      _pickedImage = null;
    });
  }
}
