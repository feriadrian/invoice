import 'package:f_line_chart/f_line_chart.dart';
import 'package:f_line_chart/line_chart_point_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/services/report_service.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/home_provider.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:myinvoice/viewmodel/report_provider.dart';
import 'package:provider/provider.dart';
import '../../../models/invoice/invoice_model.dart';
import '../../../services/home_service.dart';
import '../../../services/invoice_service.dart';
import '../../widgets/invoice_card.dart';
import 'components/filter_inital_page.dart';
import 'components/filter_rangetime_page.dart';
import 'components/filter_typebiils_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReportProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceProvider = Provider.of<InvoiceProvider>(context);
    final homeViewModel = Provider.of<HomeProvider>(context);
    const textButtonColor = Color(0xff131089);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(child:
              Consumer<ReportProvider>(builder: (context, reportProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 18, 30, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Payment Report",
                          style: heading1.copyWith(fontSize: 30),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _filterBottomSheet(context),
                        child: SizedBox(child: SvgPicture.asset(filterIcon)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    "${reportProvider.typeBiils} Transaction",
                    style: heading1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      bgColor: Colors.white,

                      // bgColor: Color.fromARGB(255, 179, 216, 94),

                      xLineNums: 6,
                      multipleLinePointsColor: const [
                        Colors.green,
                        Colors.red,
                      ],
                      multipleLinePoints: reportProvider.data,

                      showXLineText: true,

                      showYAxis: true,

                      showYLineMark: true,
                      config: LineChartPointConfig(
                          showNormalPoints: true,
                          showSelectedLine: true,
                          showSelectedPoint: true),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Row(
                    children: [
                      reportProvider.typeBiils == "Paid" ||
                              reportProvider.typeBiils == "All"
                          ? Row(
                              children: const [
                                SizedBox(
                                  height: 20,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                                Text(
                                  "Paid",
                                ),
                                SizedBox(
                                  width: 12,
                                )
                              ],
                            )
                          : const SizedBox(),
                      // const SizedBox(
                      //   width: 18,
                      // ),
                      reportProvider.typeBiils == "Unpaid" ||
                              reportProvider.typeBiils == "All"
                          ? Row(
                              children: const [
                                SizedBox(
                                  height: 20,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                                Text(
                                  "Unpaid",
                                )
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _summaryTx(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Bills",
                            style: sectionTitle,
                          ),
                          TextButton(
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    color: textButtonColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {
                                homeViewModel.ontap(1);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FutureBuilder<List<Invoice>>(
                      future: InvoiceServices().getAllInvoice(5),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: Column(
                                children: snapshot.data!
                                    .map(
                                      (e) => InvoiceCard(
                                          merchant: e.merchantName!,
                                          totalPrice: e.totalPrice!,
                                          createAt: e.updatedAt!,
                                          status: e.paymentStatusName!),
                                    )
                                    .toList()),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          })),
        ),
      ),
    );
  }

  Future<dynamic> _filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Consumer<ReportProvider>(
              builder: (context, report, _) {
                if (report.reportState == ReportState.typeBiils) {
                  return filterTypesBillsPage(context, report);
                } else if (report.reportState == ReportState.rangeTime) {
                  return filterRangeTimePage(report);
                } else {
                  return filterInitialPage(context, report);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Padding _summaryTx() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Transaction",
                style: heading2,
              ),
              FutureBuilder(
                future: ReportServices().getReport(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.transactionQuantity.toString(),
                      style: heading2,
                    );
                  } else {
                    return Text(
                      '-',
                      style: heading2,
                    );
                  }
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Bills",
                style: heading2.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 18),
              ),
              FutureBuilder(
                future: ReportServices().getReport(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      idrFormat.format(snapshot.data!.transactionTotal),
                      style: heading2,
                    );
                  } else {
                    return Text(
                      'IDR -',
                      style: heading2,
                    );
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
