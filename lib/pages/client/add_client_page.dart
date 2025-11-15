import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/custom_dropdown.dart';
import '../../common/widgets/text_field.dart';
import '../../models/client.dart';
import '../../providers/client_provider.dart';
import '../../styles/colors.dart';

class AddClient extends StatefulWidget {
  final bool isNew;
  final Client? client;
  final BuildContext? context;
  const AddClient({super.key, this.isNew = true, this.client, this.context});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  int selectedClassification = 0;
  bool isSaveButtonPressed = false;

  void saveClient() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      if (widget.isNew) {
        context.read<ClientProvider>().addClientCard(
          Client(
            name: _clientNameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
            classification: selectedClassification,
          ),
        );
      } else {
        context.read<ClientProvider>().updateClientCard(
          Client(
            id: widget.client!.id,
            name: _clientNameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
            classification: selectedClassification,
            invoiceCount: widget.client!.invoiceCount,
          ),
        );
      }
      // After saving, you probably want to close the page
      Navigator.of(context).pop();
    } else {
      if (kDebugMode) {
        print("Client form is not valid");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew && widget.client != null) {
      _clientNameController.text = widget.client!.name;
      _emailController.text = widget.client!.email;
      _phoneController.text = widget.client!.phone;
      _addressController.text = widget.client!.address;
      selectedClassification = widget.client!.classification;
    }

    _clientNameController.addListener(() {
      if (isSaveButtonPressed) {
        setState(() {
          _formKey.currentState!.validate();
        });
      }
    });
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    isSaveButtonPressed = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.isNew ? 'Add new Client' : 'Edit Client',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: saveClient,
            child: Text(
              "SAVE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: AppColor.blue,
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InputTextFormField(
                  title: "Client Name",
                  inputController: _clientNameController,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Email",
                  inputController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Phone Number",
                  inputController: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Address",
                  inputController: _addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 10),
                CustomDropdownMenu(
                  title: "Classification",
                  dropDownList: context
                      .read<ClientProvider>()
                      .classificationList
                      .entries
                      .map((entry) {
                        return DropdownMenuEntry(
                          value: entry.key, // Use the map key (int) as the value
                          label: entry
                              .value, // Use the map value (String) as the label
                        );
                      })
                      .toList(),
                  initialSelection: selectedClassification,
                  onSelected: (selectedValue) {
                    if (selectedValue != null) {
                      setState(() {
                        // The callback gives you the VALUE (the int)
                        selectedClassification = selectedValue as int;
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
