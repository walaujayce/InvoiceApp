import 'package:flutter/foundation.dart';
import '../common/widgets/card.dart';
import '../models/supplier.dart';

class SupplierProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = ["ALL"];
  List<String> get filterTypeList => _filterTypeList;

  final List<SupplierCard> _supplierCardList = [
    SupplierCard(supplier: Supplier(name: "Supplier A", invoiceCount: 10)),
    SupplierCard(supplier: Supplier(name: "Supplier B", invoiceCount: 20)),
    SupplierCard(supplier: Supplier(name: "Supplier C", invoiceCount: 30)),
  ];

  String get selectedFilter => _filterTypeList[_selectedIndex];
  List<SupplierCard> get filteredCardList {
    if (selectedFilter == _filterTypeList[0]) {
      return _supplierCardList;
    } else {
      return _supplierCardList.where((card) {
        return card.supplier.classification == _selectedIndex;
      }).toList();
    }
  }

  final Map<int, String> _classificationList = {
    0: "None",
    1: "VIP",
    2: "Regular",
    3: "Discount",
  };
  Map<int, String> get classificationList => _classificationList;

  // --- METHODS (Logic) ---

  // This replaces onFilterTypeSelected
  void updateFilter(int index) {
    _selectedIndex = index;
    notifyListeners(); // This tells the UI to rebuild
  }

  void addSupplierCard(Supplier newSupplier) {
    _supplierCardList.add(SupplierCard(supplier: newSupplier));
    notifyListeners(); // This tells the UI to rebuild
  }

  void updateSupplierCard(Supplier updatedSupplier) {
    // Find the index of the card that needs to be updated.
    if(kDebugMode){
      print("updatedSupplier:");
      print("id: ${updatedSupplier.id}");
      print("name: ${updatedSupplier.name}");
    }
    final int index = _supplierCardList.indexWhere(
      (card) => card.supplier.id == updatedSupplier.id,
    );
    // If found, update it
    if (index != -1) {
      _supplierCardList[index] = SupplierCard(supplier: updatedSupplier);
      notifyListeners();
    }
  }

  void deleteSupplierCard(String supplierId) {
    // Remove the card where the supplier ID matches.
    _supplierCardList.removeWhere((card) => card.supplier.id == supplierId);
    notifyListeners(); // Tell the UI to rebuild
  }

  void duplicateSupplierCard(Supplier currentSupplier) {
    Supplier newSupplier = Supplier(
      name: currentSupplier.name,
      email: currentSupplier.email,
      phone: currentSupplier.phone,
      address: currentSupplier.address,
      classification: currentSupplier.classification,
      invoiceCount: currentSupplier.invoiceCount,
    );
    _supplierCardList.add(SupplierCard(supplier: newSupplier));
    notifyListeners(); // This tells the UI to rebuild
  }
}
