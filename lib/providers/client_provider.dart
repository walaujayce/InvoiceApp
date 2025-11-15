import 'package:flutter/foundation.dart';
import '../common/widgets/card.dart';
import '../models/client.dart';

class ClientProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<String> _filterTypeList = ["ALL"];
  List<String> get filterTypeList => _filterTypeList;

  final List<ClientCard> _clientCardList = [
  ClientCard(client: Client(name: "Client A", invoiceCount: 10)),
  ClientCard(client: Client(name: "Client B", invoiceCount: 20)),
  ClientCard(client: Client(name: "Client C", invoiceCount: 30)),
  ];

  String get selectedFilter => _filterTypeList[_selectedIndex];
  List<ClientCard> get filteredCardList {
    if (selectedFilter == _filterTypeList[0]) {
      return _clientCardList;
    } else {
      return _clientCardList.where((card) {
        return card.client.classification == _selectedIndex;
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

  void addClientCard(Client newClient) {
    _clientCardList.add(ClientCard(client: newClient));
    notifyListeners(); // This tells the UI to rebuild
  }

  void updateClientCard(Client updatedClient) {
    // Find the index of the card that needs to be updated.
    if(kDebugMode){
      print("updatedSupplier:");
      print("id: ${updatedClient.id}");
      print("name: ${updatedClient.name}");
    }
    final int index = _clientCardList.indexWhere(
          (card) => card.client.id == updatedClient.id,
    );
    // If found, update it
    if (index != -1) {
      _clientCardList[index] = ClientCard(client: updatedClient);
      notifyListeners();
    }
  }

  void deleteClientCard(String clientId) {
    // Remove the card where the client ID matches.
    _clientCardList.removeWhere((card) => card.client.id == clientId);
    notifyListeners(); // Tell the UI to rebuild
  }

  void duplicateClientCard(Client currentClient) {
    Client newClient = Client(
      name: currentClient.name,
      email: currentClient.email,
      phone: currentClient.phone,
      address: currentClient.address,
      classification: currentClient.classification,
      invoiceCount: currentClient.invoiceCount,
    );
    _clientCardList.add(ClientCard(client: newClient));
    notifyListeners(); // This tells the UI to rebuild
  }
}
