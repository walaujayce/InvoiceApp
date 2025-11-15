import 'package:flutter/material.dart';
import 'package:invoice_app/models/business.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/customSearchBar.dart';
import '../../../providers/business_provider.dart';
import '../../../styles/colors.dart';
import 'business/add_business.dart';
import 'business/widget/business_card.dart';

class BusinessSubpage extends StatefulWidget {
  const BusinessSubpage({super.key});

  @override
  State<BusinessSubpage> createState() => _BusinessSubpageState();
}

class _BusinessSubpageState extends State<BusinessSubpage> {
  @override
  Widget build(BuildContext context) {

    // Use context.watch() to get the provider and rebuild when it changes.
    final businessProvider = context.watch<BusinessProvider>();

    // Use context.read() inside callbacks (like onPressed) to call methods
    // without rebuilding the widget.
    final businessProviderReader = context.read<BusinessProvider>();

    // The logic for filteredCardList is now inside the provider.
    final List<Business> businessList =
        businessProvider.businessList;

    void navigateToAddBusiness(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBusiness(context: context)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddBusiness(context),
        elevation: 3.0,
        backgroundColor: Colors.blueAccent[700],
        shape: CircleBorder(
          side: BorderSide(color: Colors.transparent, width: 0),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
      backgroundColor: AppColor.globalBackground,
      body: Column(
        children: [
          // Search bar
          CustomSearchBar(hintText: 'Search business by name...'),
          // Business List
          SizedBox(height: 20,),
          businessList.isEmpty
              ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No businesses!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "Please tap on the plus (+) button bellow to create a business.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          )
              : Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  // Get data from the provider's derived list
                  return BusinessCard(business: businessList[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                // Get data from the provider's derived list
                itemCount: businessList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
