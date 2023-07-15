import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/invoice/invoice_detail_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:myinvoice/viewmodel/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Provider.of<NotificationProvider>(context, listen: false)
        .getAllNotification();
    Provider.of<NotificationProvider>(context, listen: false).getUnreadCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifViewModel = Provider.of<NotificationProvider>(context);
    final dataViewModel =
        Provider.of<NotificationProvider>(context).notification?.data;
    final invoiceViewModel = Provider.of<InvoiceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 110,
        leading: Padding(
          padding: const EdgeInsets.all(11),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  notifViewModel.getUnreadCount();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: blackTextColor,
                ),
              ),
              Text(
                "Back",
                style: TextStyle(color: blackTextColor),
              ),
            ],
          ),
        ),
        // leading: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       iconSize: 14,
        //       color: primaryMain,
        //       icon: const Icon(Icons.arrow_back_ios),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     Text(
        //       'Back',
        //       style: paragraph4.copyWith(color: primaryMain),
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Notification",
          style: heading3.copyWith(color: primaryBackground),
        ),
      ),
      body: dataViewModel != null
          ? SafeArea(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    notifIcons() {
                      if (dataViewModel[index].notificationType == 'info') {
                        return SvgPicture.asset(
                          'assets/icons/info.svg',
                          color: primaryBackground,
                          width: 24,
                        );
                      } else if (dataViewModel[index].notificationType ==
                          'payment') {
                        return SvgPicture.asset(
                          'assets/icons/payment.svg',
                          color: primaryBackground,
                          width: 24,
                        );
                      } else if (dataViewModel[index].notificationType ==
                          'invoice') {
                        return SvgPicture.asset(
                          'assets/icons/invoice.svg',
                          color: primaryBackground,
                          width: 24,
                        );
                      }
                    }

                    return ListTile(
                      onTap: () {
                        notifViewModel.markAsRead(dataViewModel[index].id!);
                        setState(() {
                          dataViewModel[index].isRead = true;
                        });
                        if (dataViewModel[index].title!.contains('Success')) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => InvoiceDetailScreen(
                                isPaid: true,
                                dataViewModel[index].invoiceId!,
                              ),
                            ),
                          );
                        } else if (dataViewModel[index]
                            .title!
                            .contains('Failed')) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => InvoiceDetailScreen(
                                isPaid: false,
                                dataViewModel[index].invoiceId!,
                              ),
                            ),
                          );
                        } else if (dataViewModel[index].notificationType ==
                            'invoice') {
                          notifViewModel
                              .getInvById(dataViewModel[index].invoiceId!);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => InvoiceDetailScreen(
                                  isPaid: false,
                                  dataViewModel[index].invoiceId!),
                            ),
                          );
                        }
                      },
                      isThreeLine: true,
                      tileColor: dataViewModel[index].isRead == true
                          ? Colors.white
                          : netralCardColor,
                      leading: Container(
                        transform: Matrix4.translationValues(0, -10, 0),
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Badge(
                          elevation: 0,
                          position: BadgePosition.topEnd(top: -1, end: -2),
                          badgeColor: Colors.orange,
                          showBadge: dataViewModel[index].isRead == true
                              ? false
                              : true,
                          child: notifIcons(),
                        ),
                        // SvgPicture.asset(
                        //   dataViewModel[index].avatar!,
                        //   width: 24,
                        //   color: primaryBackground,
                        // ),
                      ),
                      title: Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 42, 0),
                        child: Text(
                          dataViewModel[index].title!,
                          style: heading3.copyWith(
                              color: primaryBackground, letterSpacing: 0.16),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 42, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataViewModel[index].content!,
                              style: notifContent.copyWith(
                                  color: primaryBackground),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              formatDateNotif(
                                DateTime.parse(dataViewModel[index].createdAt!),
                              ),
                              style: notifContent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: .5,
                      height: 1,
                      color: Colors.black.withOpacity(0.3),
                    );
                  },
                  itemCount: dataViewModel.length),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/empty_notification.svg",
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    "No Notification",
                    style: title.copyWith(color: primaryText),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "when you get notification, they'll show up here",
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// class NotifListTile extends StatelessWidget {
//   final String? color;
//   const NotifListTile({super.key, this.color});

//   @override
//   Widget build(BuildContext context) {
//     final notifViewModel = Provider.of<NotificationProvider>(context);
//     final dataViewModel =
//         Provider.of<NotificationProvider>(context).notification?.data;
//     final invoiceViewModel = Provider.of<InvoiceProvider>(context);
//     return ListView.separated(
//       itemCount: notifViewModel.notification!.data!.length,
//       itemBuilder: (context, index) {
//         return ListTile(

//         );
//       },
//     );
//   }
// }
