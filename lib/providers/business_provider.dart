import 'package:flutter/foundation.dart';
import '../models/business.dart';

class BusinessProvider extends ChangeNotifier {

  final List<Business> _businessList = [
    Business(name: "Business A", invoiceCount: 10, email: "abc@gmail.com", phone: "0123456789", totalMoney: 2000000.0, isDefault: true),
    Business(name: "Business B", invoiceCount: 20, email: "abc@gmail.com", phone: "0123456789", totalMoney: 2000000.0),
    Business(name: "Business C", invoiceCount: 30, email: "abc@gmail.com", phone: "0123456789", totalMoney: 2000000.0),
  ];
  List<Business> get businessList => _businessList; // Renamed getter

  // --- METHODS (Logic) ---

  void addBusiness(Business newBusiness) {
    _businessList.add(newBusiness); // Just add the model
    notifyListeners();
  }

  void updateBusiness(Business updatedBusiness) {
    final int index = _businessList.indexWhere(
          (business) => business.id == updatedBusiness.id,
    );
    if (index != -1) {
      _businessList[index] = updatedBusiness; // Replace the model
      notifyListeners();
    }
  }

  void setDefaultBusiness(String businessId) {
    final int index = _businessList.indexWhere(
            (business) => business.id == businessId
    );
    final int indexOfCurrentDefault = _businessList.indexWhere(
            (business) => business.isDefault == true
    );

    // If found and it's not already the default
    if (index != -1 && index != indexOfCurrentDefault) {

      // Update the old default (if one exists)
      if (indexOfCurrentDefault != -1) {
        _businessList[indexOfCurrentDefault].isDefault = false;
      }

      // Update the new default
      _businessList[index].isDefault = true;

      notifyListeners();
    }
  }

  void deleteBusiness(String businessId) {
    _businessList.removeWhere((business) => business.id == businessId);
    notifyListeners();
  }
}
