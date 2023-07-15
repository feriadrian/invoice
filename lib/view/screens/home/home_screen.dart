import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/home/home_page/home_page.dart';
import 'package:myinvoice/view/screens/invoice/invoice_page.dart';
import 'package:myinvoice/view/screens/report/report_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/home_provider.dart';
import 'package:provider/provider.dart';

import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBody: false,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: SizedBox(
            height: 84,
            child: BottomNavigationBar(
                backgroundColor: Theme.of(context).primaryColor,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                unselectedFontSize: 12,
                selectedFontSize: 12,
                elevation: 0,
                selectedLabelStyle: body4,
                currentIndex: homeViewModel.currentIndex,
                onTap: (value) {
                  homeViewModel.ontap(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        homeViewModel.currentIndex == 0
                            ? iconHomeFilled
                            : iconHome,
                        height: 26),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        homeViewModel.currentIndex == 1
                            ? iconInvoiceFilled
                            : iconInvoice,
                        height: 26),
                    label: 'Invoice',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        homeViewModel.currentIndex == 2
                            ? iconReportFilled
                            : iconReport,
                        height: 26),
                    label: 'Report',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        homeViewModel.currentIndex == 3
                            ? iconProfileFilled
                            : iconProfile,
                        height: 26),
                    label: 'Profile',
                  ),
                ]),
          ),
        ),
        body: IndexedStack(
          index: homeViewModel.currentIndex,
          children: const [
            HomePage(),
            InvoicePage(),
            ReportPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
