import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/images.dart';
import '../../../core/utils/extension/extension.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../data/model/pizza.dart';
import '../../view_model/calc/calc_cubit.dart';
import '../../view_model/invoice/invoice_cubit.dart';

class InvoiceCard extends StatefulWidget {
  const InvoiceCard({super.key});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  late GlobalKey<FormState> _formkey;
  String? _customerName;
  late TextEditingController _discountController;

  @override
  void initState() {
    _formkey = GlobalKey<FormState>();
    _discountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calculator = context.cubit<CalculatorCubit>();
    final invoice = context.cubit<InvoiceCubit>();

    _discountController.addListener(() {
      setState(() {});
    });

    return Container(
      margin: EdgeInsets.only(right: context.width * 0.04),
      width: context.width / 3.5,
      height: context.height / 1.2,
      decoration: BoxDecoration(
        boxShadow: ShadowManager.shadow,
        color: ColorManager.offWhite2.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                width: context.width / 5,
                child: SvgPicture.asset(
                  ImageManager.logoSVG,
                ),
              ),
              SizedBox(height: 25.h),
              BlocBuilder<CalculatorCubit,
                  Map<PizzaModel, Map<PizzaSize, int>>>(
                builder: (context, pizzaCounts) {
                  final filteredPizzaCounts = pizzaCounts.entries
                      .where((entry) =>
                          entry.value.values.any((count) => count > 0))
                      .toList();

                  // Calculate totals based on the discount
                  final discount = _discountController.text.isNotEmpty
                      ? num.parse(_discountController.text)
                      : 0;
                  final totalPrice =
                      calculator.getTotalPrice(discount: discount);
                  final discountAmount =
                      calculator.getTotalPrice(discount: 0) * (discount / 100);
                  final grandTotal = totalPrice; // No tax included

                  return Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(
                            children: [
                              _invoiceText('Item'),
                              _invoiceText('Quantity'),
                              _invoiceText('Price'),
                              _invoiceText('Total (EGP)'),
                            ],
                          ),
                          // Table rows
                          ...filteredPizzaCounts.expand((entry) {
                            final pizza = entry.key;
                            final sizeCounts = entry.value;

                            return sizeCounts.entries
                                .where((sizeEntry) => sizeEntry.value > 0)
                                .map((sizeEntry) {
                              final size = sizeEntry.key;
                              final count = sizeEntry.value;
                              final price =
                                  calculator.getPizzaPrice(pizza, size);
                              final totalPrice = price * count;
                              return TableRow(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: _invoiceText(
                                        '(${size.toString().split('.').last.toUpperCase()}) ${pizza.name}'),
                                  ),
                                  _invoiceText(count.toString()),
                                  _invoiceText(price.toStringAsFixed(2)),
                                  _invoiceText(totalPrice.toStringAsFixed(2)),
                                ],
                              );
                            }).toList();
                          }),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _invoiceText(
                                'Discount: ${discountAmount.toStringAsFixed(2)} EGP',
                                4),
                            _invoiceText(
                                'Grand Total: ${grandTotal.toStringAsFixed(2)} EGP',
                                4),
                          ],
                        ),
                      ),
                      if (calculator.getTotalPrice() == 0.0)
                        SizedBox(
                          height: context.height / 2.45,
                          child: Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: const Placeholder(
                              strokeWidth: 1.1,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Form(
                              key: _formkey,
                              child: MyTextFormField(
                                validateWithoutText: true,
                                hintText: 'Customer Name',
                                onSaved: (data) => _customerName = data,
                              ),
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: MyTextFormField(
                              controller: _discountController,
                              hintText: 'Discount',
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyElevatedButton(
                            title: 'Get Invoice',
                            onPressed: () {
                              if (_formkey.currentState?.validate() ?? false) {
                                _formkey.currentState?.save();
                                num discount = 0;
                                if (_discountController.text.isNotEmpty) {
                                  discount =
                                      num.parse(_discountController.text);
                                }

                                invoice.generateInvoice(
                                    pizzaCounts: pizzaCounts,
                                    customerName: _customerName!,
                                    discount: discount);
                                calculator.reset();
                                _discountController.clear();
                                _formkey.currentState?.reset();
                              }
                            },
                          ),
                          SizedBox(width: 5.w),
                          IconButton(
                            onPressed: () {
                              calculator.reset();
                              _formkey.currentState?.reset();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _invoiceText(String data, [double padding = 8.0]) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        data,
        style: context.textTheme.displayMedium?.copyWith(
          fontSize: 3.sp,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
