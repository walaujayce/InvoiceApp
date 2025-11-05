import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/edit_preview_toggle_button.dart';
import 'package:invoice_app/common/widgets/item_list_component.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  List<ItemListComponent> itemList = [];
  bool isItemListHasItem = false;
  bool _isMarkAsPaid = false;
  Widget invoiceBottomItem(
    IconData icon,
    String title,
    String remark1,
    String remark2,
  ) => Container(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
    // decoration: BoxDecoration(color: Colors.red),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            if (remark1.isNotEmpty || remark1 != "") ...[
              SizedBox(height: 5),
              Text(remark1, style: TextStyle(fontSize: 12)),
            ],
            if (remark2.isNotEmpty || remark2 != "")
              Text(remark2, style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    ),
  );

  void addItem() {
    setState(() {
      itemList.add(ItemListComponent());
      if (itemList.isNotEmpty) {
        isItemListHasItem = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Invoice",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [EditPreviewToggleButton()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 3.0,
        backgroundColor: Colors.blueAccent[700],
        shape: CircleBorder(
          side: BorderSide(color: Colors.transparent, width: 0),
        ),
        child: Icon(Icons.more_horiz_rounded, color: Colors.white, size: 30.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Column(
                children: [
                  // Company
                  SizedBox(
                    height: 100,
                    // decoration: BoxDecoration(color: Colors.redAccent[700]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Company Mail',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Company Phone',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: null,
                        ),
                      ],
                    ),
                  ),
                  // Divider
                  Divider(
                    color: Colors.grey[300],
                    height: 30, // Total height of the divider widget
                    thickness: 1, // Thickness of the line itself
                    // indent: 20, // Indent from the left
                    // endIndent: 20, // Indent from the right
                  ),
                  // Invoice Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Add client button
                      DottedBorder(
                        options: const RectDottedBorderOptions(
                          color: Color(0xFFAAA4A4),
                          dashPattern: [6, 4],
                        ),
                        child: SizedBox(
                          height: 80,
                          width: 150,
                          child: const Center(
                            child: Text(
                              "+ Add Client",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      // Invoice Detail
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'INVOICE INFO',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Invoice Number',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Invoice Date', style: TextStyle(fontSize: 14)),
                          Text('Due Date', style: TextStyle(fontSize: 14)),
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(color: Colors.redAccent),
                            child: Center(
                              child: Text(
                                "DUE DATE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Divider
                  Divider(
                    color: Colors.grey[300],
                    height: 30, // Total height of the divider widget
                    thickness: 1, // Thickness of the line itself
                    // indent: 20, // Indent from the left
                    // endIndent: 20, // Indent from the right
                  ),
                  SizedBox(height: 20),
                  // Add item button
                  if (!isItemListHasItem)
                    GestureDetector(
                      onTap: addItem,
                      child: DottedBorder(
                        options: const RectDottedBorderOptions(
                          color: Color(0xFFAAA4A4),
                          dashPattern: [6, 4],
                        ),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          height: 50,
                          // width: 150,
                          child: const Center(
                            child: Text(
                              "+ ADD ITEM",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Item list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return itemList[index];
                    },
                  ),
                  // Add item button
                  if (isItemListHasItem) ...[
                    GestureDetector(
                      onTap: addItem,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.transparent),
                        height: 50,
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          "+ ADD ITEM",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    //Divider
                    Divider(
                      color: Colors.grey[300],
                      height: 10, // Total height of the divider widget
                      thickness: 1, // Thickness of the line itself
                      // indent: 20, // Indent from the left
                      // endIndent: 20, // Indent from the right
                    ),
                    SizedBox(height: 30),
                    // Invoice payment detail
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Subtotal"),
                            Text("Discount"),
                            Text("Tax(0%)"),
                            Text("Shipping fees"),
                            Text("Total"),
                            Text("Paid"),
                            Text("Balance due"),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("\$999.00"),
                            Text("\$999.00"),
                            Text("\$999.00"),
                            Text("\$9988889999.00"),
                            Text("\$999.00"),
                            Text("\$999999.00"),
                            Text("\$999.00"),
                          ],
                        ),
                      ],
                    ),
                    // Mark as paid switch
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Mark as Paid'),
                        SizedBox(width: 10),
                        Switch(
                          value: _isMarkAsPaid,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isMarkAsPaid = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            if (isItemListHasItem) ...[
              // Big Divider
              Divider(
                color: Colors.grey[300],
                thickness: 8, // Thickness of the line itself
              ),
              Column(
                children: [
                  invoiceBottomItem(
                    Icons.textsms_outlined,
                    "Customer note",
                    "",
                    "",
                  ),
                  invoiceBottomItem(
                    Icons.drive_file_rename_outline,
                    "Signature",
                    "",
                    "",
                  ),
                  invoiceBottomItem(
                    Icons.credit_card_outlined,
                    "Payment Info",
                    "payment info",
                    "Paypal: abc@gmail.com",
                  ),
                  invoiceBottomItem(
                    Icons.card_giftcard_outlined,
                    "Thank for label",
                    "Thank you for your business",
                    "",
                  ),
                  invoiceBottomItem(
                    Icons.rule_folder_outlined,
                    "Terms & conditions",
                    "",
                    "",
                  ),
                  invoiceBottomItem(
                    Icons.image_outlined,
                    "Attachments",
                    "",
                    "",
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
