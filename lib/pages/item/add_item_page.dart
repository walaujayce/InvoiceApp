import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/custom_dropdown.dart';
import 'package:invoice_app/common/widgets/text_field.dart';
import '../../styles/colors.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();

  bool isSaveButtonPressed = false;

  void saveItem() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      String productName = _productNameController.text;
      setState(() {
        // _text = '${_nameController.text}\nEmail： $email\nPassword： $password';
      });
    } else {
      setState(() {
        // _text = '${_nameController.text}\nOOPS!!!!! Form is InValidate.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _productNameController.addListener(() {
      if (isSaveButtonPressed) {
        setState(() {
          _formKey.currentState!.validate();
        });
      }
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    isSaveButtonPressed = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Add Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: saveItem,
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
                title: "Product Name",
                inputController: _productNameController,
              ),
              SizedBox(height: 10),
              InputTextField(title: "Price"),
              SizedBox(height: 10),
              CustomDropdownMenu(
                title: "Unit",
                dropDownList: [
                  DropdownMenuEntry(value: "No unit", label: "No unit"),
                  DropdownMenuEntry(value: "hrs", label: "hrs"),
                  DropdownMenuEntry(value: "kgs", label: "kgs"),
                  DropdownMenuEntry(value: "pcs", label: "pcs"),
                ],
              ),
              SizedBox(height: 10),
              InputTextField(title: "Barcode"),
              SizedBox(height: 10),
              CustomDropdownMenu(
                title: "Category",
                dropDownList: [
                  DropdownMenuEntry(value: "No category", label: "No category"),
                  DropdownMenuEntry(value: "Goods", label: "Goods"),
                  DropdownMenuEntry(value: "Services", label: "Services"),
                  DropdownMenuEntry(value: "Merchandise", label: "Merchandise"),
                ],
              ),
              SizedBox(height: 10),
              InputTextField(title: "Description"),
            ],
          ),
        ),
      ),
    );
  }
}
