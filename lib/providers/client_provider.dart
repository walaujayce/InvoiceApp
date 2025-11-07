import 'package:flutter/material.dart';
import '../common/widgets/card.dart';

class ClientProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = ["ALL"];
  List<String> get filterTypeList => _filterTypeList;

  final List<ClientCard> _clientCardList = [
    ClientCard(clientName: "Client A", invoiceCount: 10),
    ClientCard(clientName: "Client B", invoiceCount: 20),
    ClientCard(clientName: "Client C", invoiceCount: 30),
  ];

  String get selectedFilter => _filterTypeList[_selectedIndex];
  List<ClientCard> get filteredCardList {
    if (selectedFilter == "ALL") {
      return _clientCardList;
    } else {
      return _clientCardList.where((card) {
        return card.clientClassification == selectedFilter;
      }).toList();
    }
  }

  // --- METHODS (Logic) ---

  // This replaces onFilterTypeSelected
  void updateFilter(int index) {
    _selectedIndex = index;
    notifyListeners(); // This tells the UI to rebuild
  }

  // This replaces addInvoiceCard
  void addClientCard() {
    _clientCardList.add(ClientCard(clientName: "New Item", invoiceCount: 99));
    notifyListeners(); // This tells the UI to rebuild
  }
}
