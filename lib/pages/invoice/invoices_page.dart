import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/card.dart';
import 'package:invoice_app/models/summary.dart';
import 'package:invoice_app/pages/invoice/add_invoice_page.dart';
import 'package:invoice_app/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/custom_filter.dart';
import '../../common/widgets/filter_type_container.dart';
import '../../components/summary_component.dart';
import 'package:invoice_app/providers/invoice_provider.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  final double heightFilterBar = 40;

  @override
  Widget build(BuildContext context) {

    void navigateToAddInvoice(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddInvoice()),
    );
    // Use context.watch() to get the provider and rebuild when it changes.
    final invoiceProvider = context.watch<InvoiceProvider>();

    // Use context.read() inside callbacks (like onPressed) to call methods
    // without rebuilding the widget.
    final invoiceProviderReader = context.read<InvoiceProvider>();

    // The logic for filteredCardList is now inside the provider.
    final List<CommonCard> filteredCardList = invoiceProvider.filteredCardList;
    final List<Summary> summaryList = invoiceProvider.summaryList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.globalBackground,
        title: Text(
          'Invoices',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
          ),
        ),
        actions: [
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.add_to_drive_outlined),
          SizedBox(width: 20),
          Icon(Icons.addchart_sharp),
          SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddInvoice(context),
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
          // Summary Containers (No changes needed)
          SizedBox(
            height: 100,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              itemCount: summaryList.length,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                return SummaryComponent(
                  selectedType: summaryList[index].selectedType,
                  title: summaryList[index].title,
                  count: summaryList[index].count,
                  total: summaryList[index].total,
                  linearGradient: summaryList[index].linearGradient,
                );
              },
            ),
          ),
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
                        onTap: () => invoiceProviderReader.updateFilter(index),
                        child: FilterTypeContainer(
                          height: heightFilterBar,
                          // Get data from the provider
                          content: invoiceProvider.filterTypeList[index],
                          // Get data from the provider
                          isSelected: invoiceProvider.selectedIndex == index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                    // Get data from the provider
                    itemCount: invoiceProvider.filterTypeList.length,
                  ),
                ),
              ],
            ),
          ),
          // Invoice List
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                // Get data from the provider's derived list
                return filteredCardList[index];
              },
              // Get data from the provider's derived list
              itemCount: filteredCardList.length,
            ),
          ),
        ],
      ),
    );
  }
}
