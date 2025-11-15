import 'package:flutter/material.dart';
import '../common/widgets/card.dart';
import '../models/invoice.dart';
import '../models/summary.dart';
import '../styles/colors.dart';
import '../util/enums.dart';

class InvoiceProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = [
    "ALL",
    EPaymentState.unpaid.paymentStateTitle,
    EPaymentState.partially.paymentStateTitle,
    EPaymentState.overdue.paymentStateTitle,
    EPaymentState.paid.paymentStateTitle,
  ];
  List<String> get filterTypeList => _filterTypeList;

  final List<InvoiceCard> _invoiceList = [
    InvoiceCard(invoice: Invoice(
      paymentStatus: EPaymentState.partially,
      setDate: "01/10/2025",
      clientName: "John Doe",
      invoiceID: "#INV001",
      remark1: "Due date: 25/09/2025 12:00 AM",
      remark2: "Partially:RM52.00 remaining",
      paymentStatusString: EPaymentState.partially.paymentStateTitle,
      invoiceTotal: 132,
    ),
    ),
    InvoiceCard(invoice: Invoice(
      paymentStatus: EPaymentState.overdue,
      setDate: "01/10/2025",
      clientName: "Rose",
      invoiceID: "#INV002",
      remark1: "Overdue 23 days",
      paymentStatusString: EPaymentState.overdue.paymentStateTitle,
      invoiceTotal: 55,),
    ),
    InvoiceCard(
      invoice: Invoice(
      paymentStatus: EPaymentState.paid,
      setDate: "01/10/2025",
      clientName: "Mary Land",
      invoiceID: "#INV003",
      remark1: "Mark as Paid: 14/10/2025 11:14 PM",
      paymentStatusString: EPaymentState.paid.paymentStateTitle,
      invoiceTotal: 44,
      ),
    ),
    InvoiceCard(invoice: Invoice(
      paymentStatus: EPaymentState.unpaid,
      setDate: "01/10/2025",
      clientName: "Dick Head",
      invoiceID: "#INV004",
      paymentStatusString: EPaymentState.unpaid.paymentStateTitle,
      invoiceTotal: 87,
    ),
    ),
  ];

  // --- GETTERS (Derived State) ---

  String get selectedFilter => _filterTypeList[_selectedIndex];

  List<InvoiceCard> get filteredCardList {
    if (selectedFilter == "ALL") {
      return _invoiceList;
    } else {
      return _invoiceList.where((card) {
        return card.invoice.paymentStatus.paymentStateTitle == selectedFilter;
      }).toList();
    }
  }

  List<Summary> get summaryList {

    // Helper function to calculate totals for a specific status
    Summary calculateSummary(EPaymentState? status, String title, LinearGradient gradient) {
      // Filter the list
      final List<InvoiceCard> list;
      if (status == null) {
        list = _invoiceList; // "All"
      } else {
        list = _invoiceList.where((card) => card.invoice.paymentStatus == status).toList();
      }

      // Calculate total
      double total = list.fold(0.0, (sum, card) => sum + card.invoice.invoiceTotal);

      return Summary(
        selectedType: 'invoices',
        title: title,
        count: list.length, // The dynamic count!
        total: total,       // The dynamic total!
        linearGradient: gradient,
      );
    }

    // Build the list dynamically
    return [
      calculateSummary(
          null, // null means "All"
          'All',
          AppLinearGradientColor.linearGradientBlue
      ),
      calculateSummary(
          EPaymentState.unpaid,
          'Unpaid',
          AppLinearGradientColor.linearGradientPink
      ),
      calculateSummary(
          EPaymentState.partially,
          'Partially',
          AppLinearGradientColor.linearGradientYellow
      ),
      calculateSummary(
          EPaymentState.overdue,
          'Overdue',
          AppLinearGradientColor.linearGradientOrange
      ),
      calculateSummary(
          EPaymentState.paid,
          'Paid',
          AppLinearGradientColor.linearGradientTiffany
      ),
    ];
  }

  // --- METHODS (Logic) ---

  // This replaces onFilterTypeSelected
  void updateFilter(int index) {
    _selectedIndex = index;
    notifyListeners(); // This tells the UI to rebuild
  }

  // This replaces addInvoiceCard
  void addInvoiceCard() {
    _invoiceList.add(InvoiceCard(
      invoice: Invoice(
      paymentStatus: EPaymentState.unpaid,
      setDate: "01/10/2025",
      clientName: "Dick Head",
      invoiceID: "#INV004", // You might want to make this dynamic
      paymentStatusString: EPaymentState.unpaid.paymentStateTitle,
      invoiceTotal: 87,
      ),
    ));
    notifyListeners(); // This tells the UI to rebuild
  }
}