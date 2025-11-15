import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/pages/client/add_client_page.dart';
import 'package:invoice_app/pages/item/add_item_page.dart';
import 'package:invoice_app/providers/item_provider.dart';
import 'package:invoice_app/util/enums.dart';
import 'package:provider/provider.dart';
import '../../models/client.dart';
import '../../models/invoice.dart';
import '../../models/item.dart';
import '../../models/supplier.dart';
import '../../pages/supplier/add_supplier_page.dart';
import '../../providers/client_provider.dart';
import '../../providers/supplier_provider.dart';
import '../../styles/colors.dart';

class InvoiceCard extends StatelessWidget {
  final double _containerRadius = 10.0;
  final double _remarkFontSize = 11.0;
  final double _remarkIconSize = 12.0;

  final Invoice invoice;

  const InvoiceCard({
    super.key,
    required this.invoice,
  });

  Color getRemark1Color(EPaymentState paymentStatus) {
    switch (paymentStatus) {
      case EPaymentState.paid:
        return Color(0xF5269F37);
      case EPaymentState.partially:
        return Color(0xFFDCA180);
      case EPaymentState.overdue:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  IconData getRemark1Icon(EPaymentState paymentStatus) {
    switch (paymentStatus) {
      case EPaymentState.paid:
        return Icons.check_circle_rounded;
      case EPaymentState.partially:
        return Icons.access_time_sharp;
      case EPaymentState.overdue:
        return Icons.warning_sharp;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) print("clientName: ${invoice.clientName}");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_containerRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEAEAEA), // Shadow color
              blurRadius: 2.0, // Softness of the shadow
              spreadRadius: 0.5, // How much the shadow expands (the "depth")
              offset: Offset(0, 0), // Centered, so it's "all around"
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            _containerRadius,
          ), // Must match the Container
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // label color
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: paymentStateReturnColor(invoice.paymentStatus),
                  ),
                ),
                // content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // date
                            Text(invoice.setDate, style: TextStyle(color: Colors.grey)),
                            // client name
                            Text(
                              invoice.clientName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // invoice id
                            Text(invoice.invoiceID),
                            // remark 1
                            if (invoice.remark1.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    getRemark1Icon(invoice.paymentStatus),
                                    color: getRemark1Color(invoice.paymentStatus),
                                    size: _remarkIconSize,
                                  ),
                                  SizedBox(width: 5),

                                  Text(
                                    invoice.remark1,
                                    style: TextStyle(
                                      color: getRemark1Color(invoice.paymentStatus),
                                      fontSize: _remarkFontSize,
                                    ),
                                  ),
                                ],
                              ),
                            // remark 2
                            if (invoice.remark2.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.credit_card_sharp,
                                    color: Colors.blueAccent,
                                    size: _remarkIconSize,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    invoice.remark2,
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: _remarkFontSize,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        // Right
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: paymentStateReturnColor(
                                      invoice.paymentStatus,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  invoice.paymentStatusString,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "RM${invoice.invoiceTotal}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddItem(
              isNew: false,
              item: item, // Pass the supplier's data
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(
                  "\$${item.price}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                PopupMenuButton(
                  padding: EdgeInsetsGeometry.all(0),
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 0, child: Text("Duplicate")),
                    PopupMenuItem(
                      value: 1,
                      child: Text("Delete", style: TextStyle(color: Colors.red[700])),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        context.read<ItemProvider>().duplicateItemCard(
                          item,
                        );
                        break;
                      case 1:
                        context.read<ItemProvider>().deleteItemCard(
                          item.id,
                        );
                        break;
                    }
                  },
                  color: Colors.white,
                  popUpAnimationStyle: AnimationStyle(
                    curve: Curves.easeOut, // Entry animation curve
                    duration: Duration(milliseconds: 100), // Entry animation duration
                    reverseCurve: Curves.easeIn, // Exit animation curve
                    reverseDuration: Duration(
                      milliseconds: 100,
                    ), // Exit animation duration
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  final Client client;

  const ClientCard({
    super.key,
    required this.client
  });

  @override
  Widget build(BuildContext context) {
    if(kDebugMode){
      print("client.id: ${client.id}");
      print("client.name: ${client.name}");
      print("client.invoiceCount: ${client.invoiceCount}");
    }
    return Container(
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
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF6E8FB),
          ),
          child: const Icon(Icons.person, size: 25.0, color: AppColor.blue),
        ),
        title: Text(client.name),
        subtitle: Text("${client.invoiceCount} invoices"),
        onTap: () {
          if(kDebugMode) print("Tap ${client.name} : ${client.id}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddClient(
                isNew: false,
                client: client, // Pass the supplier's data
              ),
            ),
          );
        },
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(value: 0, child: Text("Duplicate")),
            PopupMenuItem(
              value: 1,
              child: Text("Delete", style: TextStyle(color: Colors.red[700])),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 0:
                context.read<ClientProvider>().duplicateClientCard(
                  client,
                );
                break;
              case 1:
                context.read<ClientProvider>().deleteClientCard(
                  client.id,
                );
                break;
            }
          },
          color: Colors.white,
          popUpAnimationStyle: AnimationStyle(
            curve: Curves.easeOut, // Entry animation curve
            duration: Duration(milliseconds: 100), // Entry animation duration
            reverseCurve: Curves.easeIn, // Exit animation curve
            reverseDuration: Duration(
              milliseconds: 100,
            ), // Exit animation duration
          ),
        ),
      ),
    );
  }
}

class SupplierCard extends StatelessWidget {
  final Supplier supplier;

  const SupplierCard({super.key, required this.supplier});

  // --- Helper Method to Show Options ---
  void _showOptions(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   // Use shape for rounded corners
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    //   ),
    //   builder: (ctx) {
    //     // Use Wrap to make the sheet only as tall as its children
    //     return Wrap(
    //       children: [
    //         ListTile(
    //           leading: const Icon(Icons.edit_outlined),
    //           title: const Text('Edit Supplier'),
    //           onTap: () {
    //             // 1. Close the bottom sheet
    //             Navigator.pop(ctx);
    //
    //             // 2. Navigate to the AddSupplier page in edit mode
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => AddSupplier(
    //                   isNew: true,
    //                   supplier: supplier, // Pass the supplier's data
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.delete_outline, color: Colors.red[700]),
    //           title: Text(
    //             'Delete Supplier',
    //             style: TextStyle(color: Colors.red[700]),
    //           ),
    //           onTap: () {
    //             // 1. Close the bottom sheet
    //             Navigator.pop(ctx);
    //
    //             // 2. Call the provider to delete this supplier
    //             // We use context.read inside a callback
    //             context.read<SupplierProvider>().deleteSupplierCard(
    //               supplier.id,
    //             );
    //
    //             // Optional: Show a snack bar confirmation
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(
    //                 content: Text("${supplier.name} deleted."),
    //                 backgroundColor: Colors.red[700],
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF6E8FB),
          ),
          child: const Icon(
            Icons.account_balance,
            size: 25.0,
            color: AppColor.blue,
          ),
        ),
        title: Text(supplier.name),
        subtitle: Text("${supplier.invoiceCount} invoices"),
        onTap: () {
          if(kDebugMode) print("Tap ${supplier.name} : ${supplier.id}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSupplier(
                isNew: false,
                supplier: supplier, // Pass the supplier's data
              ),
            ),
          );
        },
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(value: 0, child: Text("Duplicate")),
            PopupMenuItem(
              value: 1,
              child: Text("Delete", style: TextStyle(color: Colors.red[700])),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 0:
                context.read<SupplierProvider>().duplicateSupplierCard(
                  supplier,
                );
                break;
              case 1:
                context.read<SupplierProvider>().deleteSupplierCard(
                  supplier.id,
                );
                break;
            }
          },
          color: Colors.white,
          popUpAnimationStyle: AnimationStyle(
            curve: Curves.easeOut, // Entry animation curve
            duration: Duration(milliseconds: 100), // Entry animation duration
            reverseCurve: Curves.easeIn, // Exit animation curve
            reverseDuration: Duration(
              milliseconds: 100,
            ), // Exit animation duration
          ),
        ),
      ),
    );
  }
}
