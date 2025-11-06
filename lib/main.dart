import 'package:flutter/material.dart';
import 'package:invoice_app/pages/home_page.dart';
import 'package:invoice_app/providers/client_provider.dart';
import 'package:invoice_app/providers/invoice_provider.dart';
import 'package:invoice_app/providers/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InvoiceProvider()),
        ChangeNotifierProvider(create: (context) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => ClientProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[100], // A light background
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
