import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import '../../core/utils/extension/extension.dart';
import '../../core/utils/helpers/my_snackbar.dart';
import '../../core/widgets/icon_button_tooltip.dart';
import '../controllers/excel/excel_cubit.dart';
import '../controllers/archive/archive_cubit.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const border = BorderSide(width: 2, color: ColorManager.black);

    Widget invoiceText(String text) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: context.textTheme.displayMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      );
    }

    Widget headerText(String text) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: context.textTheme.displayMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(width: 5.w),
          BlocListener<ExcelCubit, ExcelState>(
            listener: (context, state) {
              if (state is SavedToExcelSuccess) {
                customSnackBar(context, state.message);
              }
              if (state is SavedToExcelFailure) {
                customSnackBar(context, state.message);
              }
            },
            child: IconButtonWithTooltip(
              onPressed: () =>
                  context.cubit<ExcelCubit>().saveInvoicesToExcel(),
              iconData: Icons.save,
              message: 'Save To Excel',
            ),
          ),
          SizedBox(width: 5.w),
          IconButtonWithTooltip(
            onPressed: () => Navigator.pop(context),
            iconData: Icons.arrow_back,
            message: 'Back',
          ),
          SizedBox(width: 5.w),
        ],
        title: SvgPicture.asset(
          ImageManager.logoSVG,
          width: context.width * 0.15,
        ),
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
          SizedBox(
            child: Column(
              children: [
                Container(
                  color: ColorManager.orange.withOpacity(0.8),
                  child: Table(
                    border:
                        TableBorder.all(width: 2, color: ColorManager.black),
                    columnWidths: {
                      0: FixedColumnWidth(15.w),
                      4: FixedColumnWidth(33.w),
                      1: FixedColumnWidth(60.w),
                      2: const FlexColumnWidth(),
                      3: FixedColumnWidth(55.w),
                      5: FixedColumnWidth(30.w), // Added for Discount
                    },
                    children: [
                      TableRow(
                        children: [
                          headerText('.NO'),
                          headerText('Customer Name'),
                          headerText('Items'),
                          headerText('Date & Time'),
                          headerText('Discount (%)'),
                          headerText('Total (EGP)'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ArchiveCubit, ArchiveState>(
                    builder: (context, state) {
                      if (state is ArchiveLoaded) {
                        return ListView.builder(
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            final invoice = state.list[index];
                            return Container(
                              color: ColorManager.offWhite2.withOpacity(0.6),
                              child: Column(
                                children: [
                                  Table(
                                    border: const TableBorder(
                                      bottom: border,
                                      right: border,
                                      left: border,
                                      verticalInside: border,
                                    ),
                                    columnWidths: {
                                      0: FixedColumnWidth(15.w),
                                      4: FixedColumnWidth(33.w),
                                      1: FixedColumnWidth(60.w),
                                      2: const FlexColumnWidth(),
                                      3: FixedColumnWidth(55.w),
                                      5: FixedColumnWidth(30.w),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          invoiceText(
                                              invoice.invoiceNumber.toString()),
                                          invoiceText(invoice.customerName),
                                          invoiceText(invoice.items),
                                          invoiceText(
                                              '${invoice.date} - ${invoice.time}'),
                                          invoiceText('${invoice.discount} %'),
                                          invoiceText(
                                              '${invoice.totalAmount} EGP'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('No invoices found.'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
