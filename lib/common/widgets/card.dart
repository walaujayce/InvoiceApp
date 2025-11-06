import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/util/enums.dart';

class CommonCard extends StatelessWidget {
  final double _containerRadius = 10.0;
  final double _remarkFontSize = 11.0;
  final double _remarkIconSize = 12.0;
  final EPaymentState paymentStatus;
  final String setDate;
  final String clientName;
  final String invoiceID;
  final String paymentStatusString;
  final double invoiceTotal;
  final String remark1;
  final String remark2;

  const CommonCard({
    super.key,
    required this.paymentStatus,
    required this.setDate,
    required this.clientName,
    required this.invoiceID,
    this.remark1 = "",
    this.remark2 = "",
    required this.paymentStatusString,
    required this.invoiceTotal,
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
        if (kDebugMode) print("clientName: $clientName");
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_containerRadius),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFDCDCDD), // Shadow color
              blurRadius: 5.0, // Softness of the shadow
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
                    color: paymentStateReturnColor(paymentStatus),
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
                            Text(setDate, style: TextStyle(color: Colors.grey)),
                            // client name
                            Text(
                              clientName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // invoice id
                            Text(invoiceID),
                            // remark 1
                            if (remark1.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    getRemark1Icon(paymentStatus),
                                    color: getRemark1Color(paymentStatus),
                                    size: _remarkIconSize,
                                  ),
                                  SizedBox(width: 5),

                                  Text(
                                    remark1,
                                    style: TextStyle(
                                      color: getRemark1Color(paymentStatus),
                                      fontSize: _remarkFontSize,
                                    ),
                                  ),
                                ],
                              ),
                            // remark 2
                            if (remark2.isNotEmpty)
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
                                    remark2,
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
                                      paymentStatus,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  paymentStatusString,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "RM$invoiceTotal",
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
  final String itemName;
  final double itemPrice;
  final String unit;
  final String category;
  final String description;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    this.unit = "",
    this.category = "",
    this.description = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(itemName, style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$$itemPrice",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.more_vert_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  final String clientName;
  final String clientEmail;
  final String clientAddress;
  final String clientPhone;
  final String clientClassification;
  final int invoiceCount;

  const ClientCard({
    super.key,
    required this.clientName,
    this.clientEmail = "",
    this.clientAddress = "",
    this.clientPhone = "",
    this.clientClassification = "None",
    this.invoiceCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(clientName, style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$invoiceCount invoices",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Icon(Icons.more_vert_rounded),
            ],
          ),
        ],
      ),
    );
  }
}
