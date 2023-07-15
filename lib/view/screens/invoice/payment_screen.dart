import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/invoice/confirm_payment_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/bank_card.dart';
import '../../widgets/rounded_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    final List atmData = [
      'Please note down your independent VA (Virtual Account) code or number first.',
      'Then go to the nearest Mandiri ATM.',
      'Insert the ATM card and type in the PIN.',
      'Please select the Pay / Buy menu.',
      'Select the Multi Payment menu and enter the company code.',
      'After that, enter the customer code.',
      'Enter the payment amount.',
      'Select Billing, if the bill is difficult to match, please select YES.',
      'Make sure once again that the bill is appropriate, then click YES.',
      'Done, save proof of payment.',
    ];

    final List mobileBanking = [
      'After logging in, please enter the Payment menu.',
      'Then select the New Payment option – Multi Payment.',
      'The next step, select No. Virtual or enter the VA code/number of the company you got.',
      'Select the Add As New Number option.',
      'Please enter the nominal bill to be paid, then click Confirm.',
      'A confirmation page appears for the VA number, nominal, and service provider.',
      'If it is correct, please click Confirm and enter your m-Banking PIN.',
      'Done.',
    ];

    final List iBanking = [
      'Please login to your Mandiri Online account using your username and password.',
      'Then open the Payment menu, select Multi Payment.',
      'After that, choose a service provider, for example Shopee, Tokopedia, and so on.',
      'If so, enter the VA number and click Continue.',
      'Please wait until your bill appears, if it is appropriate, please click Confirm.',
      'Enter your PIN, or you can use the challenge code token.',
      "Finally, don't forget to save the proof of the transaction.",
    ];
    return Scaffold(
      appBar: MethodHelper.buildAppBar(
        context,
        'Payment',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  ChooseBankCard(
                    namaBank: invoiceProvider.payment,
                    icon: invoiceProvider.icon,
                    isNA: false,
                    accountNumber: '',
                    isClicked: false,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CardCopiable(
                      title: 'Account Number',
                      number: invoiceProvider.accountNumber),
                  SizedBox(
                    height: 15,
                  ),
                  CardCopiable(
                      title: 'Total Amount',
                      number: idrFormat.format(invoiceProvider.bill)),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Cara Pembayaran',
                      style: heading3.copyWith(color: blackTextColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              invoiceProvider.pageControllerPembayaran
                                  .animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                            },
                            child: invoiceProvider.currentIndexPembayaran == 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: primaryBackground, width: 3),
                                      ),
                                    ),
                                    child: Text(
                                      'ATM',
                                      style: heading4.copyWith(
                                          color: primaryBackground),
                                    ),
                                  )
                                : Text(
                                    'ATM',
                                    style: heading5.copyWith(
                                        color: netralDisableColor),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              invoiceProvider.pageControllerPembayaran
                                  .animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                            },
                            child: invoiceProvider.currentIndexPembayaran == 1
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: primaryBackground, width: 3),
                                      ),
                                    ),
                                    child: Text(
                                      'Mobile Banking',
                                      style: heading4.copyWith(
                                          color: primaryBackground),
                                    ),
                                  )
                                : Text(
                                    'Mobile Banking',
                                    style: heading5.copyWith(
                                        color: netralDisableColor),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              invoiceProvider.pageControllerPembayaran
                                  .animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                            },
                            child: invoiceProvider.currentIndexPembayaran == 2
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: primaryBackground, width: 3),
                                      ),
                                    ),
                                    child: Text(
                                      'i-Banking',
                                      style: heading4.copyWith(
                                          color: primaryBackground),
                                    ),
                                  )
                                : Text(
                                    'i-Banking',
                                    style: heading5.copyWith(
                                        color: netralDisableColor),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: PageView(
                        controller: invoiceProvider.pageControllerPembayaran,
                        onPageChanged: (value) {
                          invoiceProvider.changePagePembayaran(value);
                        },
                        children: [
                          SingleChildScrollView(
                              child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 9),
                            decoration: BoxDecoration(
                              color: netralCardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('ATM BERSAMA / MANDIRI / PRIMA'),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: atmData.length,
                                    itemBuilder: (context, index) {
                                      return CaraPembayaranCard(
                                          count: (index + 1).toString(),
                                          title: atmData[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                          SingleChildScrollView(
                              child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 9),
                            decoration: BoxDecoration(
                              color: netralCardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Mobile Banking'),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mobileBanking.length,
                                    itemBuilder: (context, index) {
                                      return CaraPembayaranCard(
                                          count: (index + 1).toString(),
                                          title: mobileBanking[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                          SingleChildScrollView(
                              child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 9),
                            decoration: BoxDecoration(
                              color: netralCardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Internet Banking'),
                                Container(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: iBanking.length,
                                    itemBuilder: (context, index) {
                                      return CaraPembayaranCard(
                                          count: (index + 1).toString(),
                                          title: iBanking[index]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    RoundedButton(
                        title: 'Confirm Payment',
                        press: () async {
                          await invoiceProvider.resetnameImage();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmPaymentScreen(

                                  // invoiceId: invoiceId,
                                  // nameCustomer: nameCustomer,
                                  // totalPayment: totalPayment
                                  ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildBottom() {
  //   return Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(horizontal: 30),
  //     child: RoundedButton(title: 'title', press: () {}),
  //   );
  // }
}

class CaraPembayaranCard extends StatelessWidget {
  const CaraPembayaranCard({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$count. ",
          style: paragraph4.copyWith(color: blackTextColor),
        ),
        Expanded(
          child: Text(
            title,
            style: paragraph4.copyWith(color: blackTextColor),
          ),
        ),
      ],
    );
  }
}

class CardCopiable extends StatelessWidget {
  const CardCopiable({
    Key? key,
    required this.title,
    required this.number,
  }) : super(key: key);

  final String title, number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: paragraph4.copyWith(color: blackTextColor),
        ),
        Row(
          children: [
            Text(
              number,
              style: heading4.copyWith(color: blackTextColor),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: number));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied'),
                  ),
                );
              },
              child: Text(
                'Copy',
                style: heading7.copyWith(color: primaryMain),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset('assets/icons/fi-rr-copy-alt.svg'),
          ],
        )
      ],
    );
  }
}
