import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/card.dart';
import 'package:invoice_app/common/widgets/import_and_export_button.dart';
import 'package:invoice_app/providers/supplier_provider.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/customSearchBar.dart';
import '../../common/widgets/custom_filter.dart';
import '../../common/widgets/filter_type_container.dart';
import '../../styles/colors.dart';
import 'add_supplier_page.dart';

class SuppliersPage extends StatefulWidget {
  const SuppliersPage({super.key});

  @override
  State<SuppliersPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SuppliersPage> {
  final double heightFilterBar = 40.0;
  bool isSupplierListEmpty = true;

  @override
  Widget build(BuildContext context) {

    // Use context.watch() to get the provider and rebuild when it changes.
    final supplierProvider = context.watch<SupplierProvider>();

    // Use context.read() inside callbacks (like onPressed) to call methods
    // without rebuilding the widget.
    final supplierProviderReader = context.read<SupplierProvider>();

    // The logic for filteredCardList is now inside the provider.
    final List<SupplierCard> filteredCardList = supplierProvider.filteredCardList;

    void navigateToAddSupplier(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSupplier(context:context)),
    );

    if (kDebugMode) print("filteredCardList: $filteredCardList");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        actions: [ImportAndExportButton()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddSupplier(context),
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
          CustomSearchBar(hintText: 'Search items'),
          // Filter bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: heightFilterBar,
            child: Row(
              children: [
                // customize filter icon
                SizedBox(width: 10.0),
                CustomFilterIcon(height: heightFilterBar),
                // list of different type filters
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        // Call the provider's method
                        onTap: () => supplierProviderReader.updateFilter(index),
                        child: FilterTypeContainer(
                          height: heightFilterBar,
                          // Get data from the provider
                          content: supplierProvider.filterTypeList[index],
                          // Get data from the provider
                          isSelected: supplierProvider.selectedIndex == index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                    // Get data from the provider
                    itemCount: supplierProvider.filterTypeList.length,
                  ),
                ),
              ],
            ),
          ),
          // Invoice List
          filteredCardList.isEmpty
              ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "No clients!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    letterSpacing: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "Please tap on the plus (+) button bellow to create an client.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.5,
                    ),
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
                  return filteredCardList[index];
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                // Get data from the provider's derived list
                itemCount: filteredCardList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
