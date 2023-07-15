import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/models/bank/bank_model.dart';
import 'package:myinvoice/models/invoice_detail/invoice_detail_model.dart';
import 'package:myinvoice/services/invoice_service.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/invoice/payment_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';
import 'package:myinvoice/view/widgets/rounded_button.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/bank_card.dart';
import '../../widgets/item_desciption.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen(
    this.id, {
    super.key,
    required this.isPaid,
  });
  final int id;
  final bool isPaid;
  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    return Scaffold(
      appBar: MethodHelper.buildAppBar(
        context,
        'Invoice Details',
      ),
      body: FutureBuilder<InvoiceDetail>(
        future: InvoiceServices().getInvoiceById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            InvoiceDetail data = snapshot.data!;
            invoiceProvider.getSubTotal(data.totalPrice ?? 0);
            invoiceProvider.setInvoiceData(data);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Store Name",
                          style: body3.copyWith(color: blackTextColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data.merchantName ?? '',
                          style: paragraph4.copyWith(color: blackTextColor),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Invoice #${data.invoiceId}',
                              style: paragraph4.copyWith(
                                  color: netralDisableColor),
                            ),
                            const Spacer(),
                            Text(
                              'Date Invoice: ${formatDateBasic(DateTime.parse(data.createdAt!))}',
                              style: paragraph4.copyWith(color: blackTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Full Name',
                          style: body3.copyWith(color: blackTextColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              data.customerName!,
                              style: paragraph4.copyWith(color: blackTextColor),
                            ),
                            const Spacer(),
                            Text(
                              'Date Overdue: ${formatDateBasic(DateTime.parse(data.dueAt!))}',
                              style: paragraph4.copyWith(color: blackTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data.customerAddress ??
                              'Mohon Input Alamat Anda Di profile',
                          style: paragraph4.copyWith(color: blackTextColor),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                    Column(
                      children: data.invoiceDetail!
                          .map(
                            (e) => ItemDescriptionCard(e),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (data.paymentStatusName == 'Unpaid')
                      GestureDetector(
                        onTap: () async {
                          var banks = await InvoiceServices()
                              .getAllBank(data.merchantId!);
                          _choosePayment(context, banks);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: netralCardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Payment Method',
                                style: subhead2.copyWith(color: blackTextColor),
                              ),
                              const Spacer(),
                              Text(
                                invoiceProvider.payment,
                                style: paragraph4.copyWith(
                                    color: netralDisableColor),
                              ),
                              SvgPicture.asset(
                                arrow,
                                color: netralDisableColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: netralCardColor),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total Product',
                                style: heading7.copyWith(color: blackTextColor),
                              ),
                              const Spacer(),
                              Text(
                                data.productQuantity.toString(),
                                style:
                                    paragraph4.copyWith(color: blackTextColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                'Sub Total',
                                style: heading7.copyWith(color: blackTextColor),
                              ),
                              const Spacer(),
                              Text(
                                idrFormat.format(data.totalPrice),
                                style:
                                    paragraph4.copyWith(color: blackTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: heading7.copyWith(color: noteTextColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'It was pleasure doing business with you',
                          style: heading7.copyWith(
                            color: noteTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Term & Conditions',
                          style: heading7.copyWith(color: noteTextColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Please make the payment by the due',
                          style: heading7.copyWith(
                            color: noteTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: buildBottom(isPaid, context),
      extendBody: true,
    );
  }

  Future<dynamic> _choosePayment(BuildContext context, List<BankModel> data) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 11),
                  height: 3,
                  width: 85,
                  decoration: BoxDecoration(
                    color: blackTextColor,
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
              ),
              Text(
                'Choose Payment Method',
                style: heading3.copyWith(color: blackTextColor),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Bank Transfer (Manual Verification)',
                style: heading7.copyWith(color: blackTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              ChooseBankCard(
                icon: bni,
                namaBank: 'Bank BNI',
                isNA: invoiceProvider.checkBakMerch('BNI', data),
                accountNumber: data.first.bankNumber.toString(),
              ),
              ChooseBankCard(
                icon: bca,
                namaBank: 'Bank BCA',
                isNA: invoiceProvider.checkBakMerch('BCA', data),
                accountNumber: data.first.bankNumber.toString(),
              ),
              ChooseBankCard(
                icon: mandiri,
                namaBank: 'Bank Mandiri',
                isNA: invoiceProvider.checkBakMerch('MANDIRI', data),
                accountNumber: data.first.bankNumber.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Payment Gateway (Automatic Verification)',
                style: heading7.copyWith(color: blackTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              ChooseBankCard(
                namaBank: 'Bank BNI',
                icon: bni,
                accountNumber: data.first.bankNumber.toString(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildBottom(bool isPaid, BuildContext context) {
    final invoiceProvider =
        Provider.of<InvoiceProvider>(context, listen: false);
    if (isPaid) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 14,
        ),
        child: RoundedButton(
            title: 'Download',
            isLoading: invoiceProvider.isloading,
            press: () async {
              invoiceProvider.onPress();
              await InvoiceServices().downloadPDF(id);
              // if (await InvoiceServices().downloadInvoice(id)) {
              //   showDialog(
              //     context: context,
              //     builder: (context) {
              //       return Dialog(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: SizedBox(
              //           width: 270,
              //           height: 150,
              //           child: Column(
              //             children: [
              //               SizedBox(
              //                 height: 12,
              //               ),
              //               SvgPicture.asset('assets/icons/fi-sr-checkbox.svg'),
              //               Text(
              //                 'Download Invoice Success',
              //                 style:
              //                     heading3.copyWith(color: primaryBackground),
              //               ),
              //               SizedBox(
              //                 height: 5,
              //               ),
              //               Text(
              //                 textAlign: TextAlign.center,
              //                 'The invoice has been successfully saved on your device',
              //                 style: paragraph4.copyWith(
              //                     color: netralDisableColor),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   );
              // }
              invoiceProvider.onPress();
            }),
      );
    } else {
      return PayNowCard(
        id: id,
      );
    }
  }
}

class PayNowCard extends StatelessWidget {
  const PayNowCard({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final invoicePro = Provider.of<InvoiceProvider>(context);
    return Container(
      height: 80,
      color: Colors.white,
      // color: Colors.red,
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total Bill',
                style: paragraph4.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                invoicePro.bill == 0
                    ? '...'
                    : idrFormat.format(invoicePro.bill),
                style: body4.copyWith(color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          invoicePro.payment == 'Choose'
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 41.5, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFCDCDCD),
                  ),
                  child: Text(
                    'Pay Now',
                    style: heading4.copyWith(color: blackTextColor),
                  ),
                )
              : ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryMain,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 41.5, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ));
                  },
                  child: Text(
                    'Pay Now',
                    style: heading4.copyWith(color: Colors.white),
                  ))
        ],
      ),
    );
  }
}
