import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/common/widgets/custom_dropdown.dart';
import 'package:invoice_app/common/widgets/text_field.dart';
import 'package:invoice_app/providers/item_provider.dart';
import 'package:provider/provider.dart';
import '../../models/item.dart';
import '../../styles/colors.dart';

class AddItem extends StatefulWidget {
  final bool isNew;
  final Item? item;
  final BuildContext? context;
  const AddItem({
    super.key,
    this.isNew = true,
    this.item,
    this.context,
  });


  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isSaveButtonPressed = false;

  void saveItem() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      if (widget.isNew) {
        context.read<ItemProvider>().addItemCard(Item(
          name: _productNameController.text,
          price: double.tryParse(_priceController.text) ?? 0.0,
          unit: _unitController.text,
          category: _categoryController.text,
          description: _descriptionController.text,
        ));
      } else {
        context.read<ItemProvider>().updateItemCard(Item(
          id: widget.item!.id,
          name: _productNameController.text,
          price: double.tryParse(_priceController.text) ?? 0.0,
          unit: _unitController.text,
          category: _categoryController.text,
          description: _descriptionController.text,
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

    if (!widget.isNew && widget.item != null) {
      _productNameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
      _unitController.text = widget.item!.unit;
      _categoryController.text = widget.item!.category;
      _descriptionController.text = widget.item!.description;
    }

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
    _priceController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    isSaveButtonPressed = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.isNew ? 'Add Item' : 'Edit Item',
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
      body: SingleChildScrollView(
        child: Form(
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
                InputTextField(title: "Price", inputController: _priceController,),
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
                // InputTextField(title: "Barcode"),
                // SizedBox(height: 10),
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
                InputTextField(title: "Description", inputController: _descriptionController,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
