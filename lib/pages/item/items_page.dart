import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/import_and_export_button.dart';
import 'package:invoice_app/providers/item_provider.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/card.dart';
import '../../common/widgets/customSearchBar.dart';
import '../../common/widgets/custom_filter.dart';
import '../../common/widgets/filter_type_container.dart';
import '../../styles/colors.dart';
import 'add_item_page.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  final double heightFilterBar = 40;

  @override
  Widget build(BuildContext context) {
    void navigateToAddItem(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItem()),
    );
    // Use context.watch() to get the provider and rebuild when it changes.
    final itemProvider = context.watch<ItemProvider>();

    // Use context.read() inside callbacks (like onPressed) to call methods
    // without rebuilding the widget.
    final itemProviderReader = context.read<ItemProvider>();

    // The logic for filteredCardList is now inside the provider.
    final List<ItemCard> filteredCardList = itemProvider.filteredCardList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.globalBackground,
        title: Text(
          'Items',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 22.0,
          ),
        ),
        actions: [
          GestureDetector(onTap: (){} ,child: ImportAndExportButton()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddItem(context),
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
                        onTap: () => itemProviderReader.updateFilter(index),
                        child: FilterTypeContainer(
                          height: heightFilterBar,
                          // Get data from the provider
                          content: itemProvider.filterTypeList[index],
                          // Get data from the provider
                          isSelected: itemProvider.selectedIndex == index,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 10.0),
                    // Get data from the provider
                    itemCount: itemProvider.filterTypeList.length,
                  ),
                ),
              ],
            ),
          ),
          // Invoice List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  // Get data from the provider's derived list
                  return filteredCardList[index];
                },
                separatorBuilder: (context, index) {return SizedBox(height: 10,);},
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
