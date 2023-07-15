import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myinvoice/view/screens/splash/splash_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/home_provider.dart';
import 'package:myinvoice/viewmodel/auth_provider.dart';
import 'package:myinvoice/viewmodel/invoice_provider.dart';
import 'package:myinvoice/viewmodel/notification_provider.dart';
import 'package:myinvoice/viewmodel/profile_provider.dart';
import 'package:myinvoice/viewmodel/report_provider.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => InvoiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryBackground,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
