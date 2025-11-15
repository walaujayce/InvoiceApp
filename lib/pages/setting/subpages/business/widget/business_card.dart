import 'package:flutter/material.dart';
import 'package:invoice_app/pages/setting/subpages/business/add_business.dart';
import 'package:provider/provider.dart';
import '../../../../../models/business.dart';
import '../../../../../providers/business_provider.dart';
import '../../../../../styles/colors.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  const BusinessCard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEAEAEA), // Shadow color
            blurRadius: 2.0, // Softness of the shadow
            spreadRadius: 0.5, // How much the shadow expands (the "depth")
            offset: Offset(0, 0), // Centered, so it's "all around"
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section 1
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // business name, email, phone, icon
                  Row(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF6E8FB),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 25.0,
                          color: AppColor.blue,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // business name
                          Text(
                            "${business.name} ${business.isDefault ? "(default)" : ""}",
                          ),
                          // business email
                          Text(business.email, style: TextStyle(fontSize: 12)),
                          // business phone
                          Text(business.phone, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  // business total money, invoice count
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${business.totalMoney}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${business.invoiceCount} invoices",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Section 2
          Row(
            children: [
              VerticalDivider(color: Colors.blueGrey, thickness: 0.5, width: 1),
              SizedBox(
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBusiness(
                              isNew: false,
                              business: business, // Pass the supplier's data
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Edit", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                    Divider(color: Colors.blueGrey, height: 1, thickness: 0.5),
                    GestureDetector(
                      onTap: () {
                        context.read<BusinessProvider>().setDefaultBusiness(
                          business.id,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text("Default", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
