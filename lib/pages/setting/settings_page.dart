import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/pages/setting/subpages/business_subpage.dart';

import '../../styles/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Section 1
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFEAEAEA), // Shadow color
                      blurRadius: 2.0, // Softness of the shadow
                      spreadRadius:
                          0.5, // How much the shadow expands (the "depth")
                      offset: Offset(0, 0), // Centered, so it's "all around"
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Manage your businesses
                    ListTile(
                      leading: const Icon(Icons.pentagon_outlined, color: AppSettingColor.settingIconColor,),
                      title: const Text('Manage your businesses'),
                      subtitle: const Text("Logo,Name,Signature, and Payment Information"),
                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BusinessSubpage()),
                        );
                      },
                    ),
                    // Language & Format
                    ListTile(
                      leading: const Icon(Icons.language_rounded, color: AppSettingColor.settingIconColor,),
                      title: const Text('Language & Format'),
                      subtitle: const Text("Currency,date format,language"),

                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                      },
                    ),
                    // Customize invoice
                    ListTile(
                      leading: const Icon(Icons.mode_edit_outline_rounded, color: AppSettingColor.settingIconColor,),
                      title: const Text('Customize invoice'),
                      subtitle: const Text("Invoice number Prefix e.g:INV"),

                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                      },
                    ),
                    // Dark Mode
                    ListTile(
                      leading: const Icon(Icons.light_mode, color: AppSettingColor.settingIconColor,),
                      title: const Text('Dark Mode'),
                      subtitle: const Text("Switch between light and dark theme"),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {
                          // Handle switch value change
                        },
                      ),
                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Section 2
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFEAEAEA), // Shadow color
                      blurRadius: 2.0, // Softness of the shadow
                      spreadRadius:
                          0.5, // How much the shadow expands (the "depth")
                      offset: Offset(0, 0), // Centered, so it's "all around"
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Report
                    ListTile(
                      leading: const Icon(Icons.insert_chart_outlined_rounded, color: AppSettingColor.settingIconColor,),
                      title: const Text('Report'),
                      subtitle: const Text("Summary of sales reports"),
                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                      },
                    ),
                    // Export invoice data to Excel file
                    ListTile(
                      leading: const Icon(Icons.file_present, color: AppSettingColor.settingIconColor,),
                      title: const Text('Export invoice data to Excel file'),
                      subtitle: const Text("You can edit with Excel or Google Sheet"),
                      onTap: () {
                        if (kDebugMode) {
                          print("tile is pressed");
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
