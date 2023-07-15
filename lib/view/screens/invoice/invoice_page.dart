import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/models/invoice/invoice_model.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/invoice/invoice_detail_screen.dart';
import 'package:myinvoice/view/screens/invoice/payment_status_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/invoice_card.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:provider/provider.dart';

import '../../../services/invoice_service.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

ScrollController _scrollController = ScrollController();

class _InvoicePageState extends State<InvoicePage> {
  int limit = 7;
  addLimit() {
    setState(() {
      limit += 7;
    });
    print('=========== $limit');
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        addLimit();
      }
      print(' $limit');
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    addLimit;
    limit = 7;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              Text(
                'Invoice List',
                style: title.copyWith(color: pressed),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      invoiceProvider.pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: invoiceProvider.currendIndex == 0
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
                              'Unpaid',
                              style:
                                  heading4.copyWith(color: primaryBackground),
                            ),
                          )
                        : Text(
                            'Unpaid',
                            style: heading5.copyWith(color: netralDisableColor),
                          ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () {
                      invoiceProvider.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: invoiceProvider.currendIndex == 1
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
                              'Pending',
                              style:
                                  heading4.copyWith(color: primaryBackground),
                            ),
                          )
                        : Text(
                            'Pending',
                            style: heading5.copyWith(color: netralDisableColor),
                          ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () {
                      invoiceProvider.pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: invoiceProvider.currendIndex == 2
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
                              'Paid',
                              style:
                                  heading4.copyWith(color: primaryBackground),
                            ),
                          )
                        : Text(
                            'Paid',
                            style: heading5.copyWith(color: netralDisableColor),
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView(
                  controller: invoiceProvider.pageController,
                  onPageChanged: (value) {
                    invoiceProvider.changePage(value);
                  },
                  children: [
                    FutureBuilder<List<Invoice>>(
                      future: InvoiceServices().getAllInvoice(limit, isPaid: 1),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                  children: snapshot.data!.isNotEmpty
                                      ? snapshot.data!
                                          .map(
                                            (e) => InvoiceCard(
                                                merchant: e.merchantName!,
                                                totalPrice: e.totalPrice!,
                                                createAt: e.createdAt!,
                                                status:
                                                    e.paymentStatusName ?? '',
                                                press: () async {
                                                  invoiceProvider
                                                      .resetPayment();
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return InvoiceDetailScreen(
                                                          isPaid: false,
                                                          e.invoiceId!);
                                                    },
                                                  ));
                                                }),
                                          )
                                          .toList()
                                      : [EmptyScrenn()]));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<Invoice>>(
                      future: InvoiceServices().getAllInvoice(limit, isPaid: 2),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                              child: Column(
                                  children: snapshot.data!.isNotEmpty
                                      ? snapshot.data!
                                          .map(
                                            (e) => InvoiceCard(
                                                merchant: e.merchantName!,
                                                totalPrice: e.totalPrice!,
                                                createAt: e.createdAt!,
                                                status:
                                                    e.paymentStatusName ?? '',
                                                press: () async {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return StatusPembayaranScreen();
                                                    },
                                                  ));
                                                }),
                                          )
                                          .toList()
                                      : [EmptyScrenn()]));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<Invoice>>(
                      future: InvoiceServices().getAllInvoice(limit, isPaid: 3),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                              child: Column(
                                  children: snapshot.data!.isNotEmpty
                                      ? snapshot.data!
                                          .map(
                                            (e) => InvoiceCard(
                                                merchant: e.merchantName!,
                                                totalPrice: e.totalPrice!,
                                                createAt: e.createdAt!,
                                                status:
                                                    e.paymentStatusName ?? '',
                                                press: () async {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return InvoiceDetailScreen(
                                                          isPaid: true,
                                                          e.invoiceId!);
                                                    },
                                                  ));
                                                }),
                                          )
                                          .toList()
                                      : [EmptyScrenn()]));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyInvoiceScreen extends StatelessWidget {
  const EmptyInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SvgPicture.asset('assets/icons/Receipt-pana 1.svg')],
    );
  }
}

class InvoiceCard1 extends StatelessWidget {
  const InvoiceCard1({
    Key? key,
    required this.paid,
    this.press,
  }) : super(key: key);

  final bool paid;
  final Function()? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: netralCardColor,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff0e1f351f).withOpacity(0.12),
                  blurRadius: 3,
                  offset: const Offset(0, 3)),
            ]),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(homeSmall),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  'Seven Store',
                  style: heading5.copyWith(color: blackTextColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Nov 22, 2022',
                  style: paragraph4.copyWith(color: netralDisableColor),
                ),
              ],
            ),
            const SizedBox(
              width: 39,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'IDR. 1.120.000,-',
                  style: subhead2.copyWith(color: blackTextColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  paid ? 'Paid' : 'Unpaid',
                  style: heading7.copyWith(
                      color: paid ? Colors.greenAccent : redColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyScrenn extends StatelessWidget {
  const EmptyScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset('assets/icons/Frame 565.svg'));
  }
}
