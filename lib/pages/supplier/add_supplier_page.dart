import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/providers/supplier_provider.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/custom_dropdown.dart';
import '../../common/widgets/text_field.dart';
import '../../models/supplier.dart';
import '../../styles/colors.dart';

class AddSupplier extends StatefulWidget {
  final bool isNew;
  final Supplier? supplier;
  final BuildContext? context;
  const AddSupplier({
    super.key,
    this.isNew = true,
    this.supplier,
    this.context,
  });

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final _formKey = GlobalKey<FormState>();
  final _supplierNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  // Add controller or variable for Dropdown
  String _selectedClassification = "ALL";

  bool isSaveButtonPressed = false;

  void saveSupplier() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      if (widget.isNew) {
        context.read<SupplierProvider>().addSupplierCard(Supplier(
          name: _supplierNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          classification: _selectedClassification,
        ));
      } else {
        context.read<SupplierProvider>().updateSupplierCard(Supplier(
          id: widget.supplier!.id,
          name: _supplierNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          classification: _selectedClassification,
        ));
      }
      // After saving, you probably want to close the page
      Navigator.of(context).pop();
    } else {
      if (kDebugMode) {
        print("Form is not valid");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew && widget.supplier != null) {
      _supplierNameController.text = widget.supplier!.name;
      _emailController.text = widget.supplier!.email;
      _phoneController.text = widget.supplier!.phone;
      _addressController.text = widget.supplier!.address;
      _selectedClassification = widget.supplier!.classification;
    }

    _supplierNameController.addListener(() {
      if (isSaveButtonPressed) {
        setState(() {
          _formKey.currentState!.validate();
        });
      }
    });
  }

  @override
  void dispose() {
    _supplierNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.isNew ? 'Add new Supplier' : 'Edit Supplier',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: saveSupplier,
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
          child: Column(
            children: [
              InputTextFormField(
                title: "Supplier Name",
                inputController: _supplierNameController,
              ),
              SizedBox(height: 10),
              InputTextField(title: "Email", inputController: _emailController),
              SizedBox(height: 10),
              InputTextField(title: "Phone Number"),
              SizedBox(height: 10),
              InputTextField(title: "Address"),
              SizedBox(height: 10),
              CustomDropdownMenu(
                title: "Supplier Classification",
                dropDownList: [
                  DropdownMenuEntry(value: "None", label: "None"),
                  DropdownMenuEntry(value: "VIP", label: "VIP"),
                  DropdownMenuEntry(value: "Regular", label: "Regular"),
                  DropdownMenuEntry(value: "Discount", label: "Discount"),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
