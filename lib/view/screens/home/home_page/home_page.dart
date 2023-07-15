import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/models/notification/unread_count.dart';
import 'package:myinvoice/services/home_service.dart';
import 'package:myinvoice/services/invoice_service.dart';
import 'package:myinvoice/services/notification_service.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/notification/notification_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/home_summary.dart';
import 'package:myinvoice/view/widgets/invoice_card.dart';
import 'package:myinvoice/viewmodel/home_provider.dart';
import 'package:myinvoice/viewmodel/notification_provider.dart';
import 'package:myinvoice/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../../models/invoice/invoice_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeProvider>(context);
    final reportViewModel = Provider.of<HomeProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    const textButtonColor = Color(0xff131089);
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                children: [
                  Container(
                    height: 195,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Invoice",
                                style: title.copyWith(color: Colors.white),
                              ),
                              FutureBuilder<UnreadNotifCount>(
                                future:
                                    NotificationServices().fetchNotifCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Badge(
                                      showBadge:
                                          snapshot.data!.data!.unreadCount! > 0
                                              ? true
                                              : false,
                                      toAnimate: true,
                                      animationType: BadgeAnimationType.scale,
                                      badgeContent: Text(
                                        textScaleFactor: 0.5,
                                        snapshot.data!.data!.unreadCount!
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      badgeColor: redColor,
                                      position:
                                          BadgePosition.topEnd(top: 2, end: 8),
                                      child: IconButton(
                                        icon: SvgPicture.asset(iconNotifFilled,
                                            width: 24),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) {
                                                return const NotificationScreen();
                                              },
                                            ),
                                          );
                                        },
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) {
                                              return const NotificationScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(iconNotifFilled,
                                          width: 24),
                                      // icon: SvgPicture.asset(iconNotifFilled,
                                      //     width: 24),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Welcome!',
                            style: body3.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Text(
                            profileProvider.customer.fullName ?? '',
                            style: body1.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Summary",
                              style: sectionTitle,
                            ),
                            TextButton(
                                child: const Text(
                                  'Details',
                                  style: TextStyle(
                                      color: textButtonColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                onPressed: () {
                                  homeViewModel.ontap(2);
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: FutureBuilder(
                                future: HomeService().getReport(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return HomeSummary(
                                      bill: snapshot.data!.data!.totalPaid,
                                      status: 'Total Paid',
                                    );
                                  } else {
                                    return HomeSummary(
                                      bill: 0,
                                      status: 'Total Paid',
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Flexible(
                              flex: 1,
                              child: FutureBuilder(
                                future: HomeService().getReport(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return HomeSummary(
                                      bill: snapshot.data!.data!.totalUnpaid,
                                      status: 'Total Unpaid',
                                    );
                                  } else {
                                    return HomeSummary(
                                      bill: 0,
                                      status: 'Total Unpaid',
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder<List<Invoice>>(
                    future: InvoiceServices().getAllInvoice(5),
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
                                            status: e.paymentStatusName ?? '',
                                          ),
                                        )
                                        .toList()
                                    : [SizedBox()]));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
