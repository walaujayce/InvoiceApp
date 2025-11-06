import 'package:flutter/material.dart' hide MenuBar;
import 'package:invoice_app/pages/invoice/add_invoice_page.dart';
import 'package:invoice_app/pages/item/add_item_page.dart';
import 'package:invoice_app/pages/settings_page.dart';
import 'package:invoice_app/pages/suppliers_page.dart';
import 'package:invoice_app/components/menu_bar.dart';
import 'client/clients_page.dart';
import 'estimates_page.dart';
import 'invoice/invoices_page.dart';
import 'item/items_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _selectedPage = AddItem();
  int _selectedIndex = 0;

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _selectedPage = const InvoicesPage();
          break;
        case 1:
          _selectedPage = const EstimatesPage();
          break;
        case 2:
          _selectedPage = const ItemsPage();
          break;
        case 3:
          _selectedPage = const ClientsPage();
          break;
        case 4:
          _selectedPage = const SuppliersPage();
          break;
        case 5:
          _selectedPage = const SettingsPage();
          break;
        default:
          _selectedPage = const InvoicesPage(); // A sensible default
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            MenuBar(
              onMenuItemSelected: _onMenuItemSelected,
              selectedIndex: _selectedIndex,
            ),
            Expanded(child: _selectedPage),
          ],
        )
      ),
    );
  }
}
