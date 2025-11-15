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
  const AddItem({super.key, this.isNew = true, this.item, this.context});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool isSaveButtonPressed = false;
  int selectedUnit = 0;
  int selectedCategory = 0;

  void saveItem() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      if (widget.isNew) {
        context.read<ItemProvider>().addItemCard(
          Item(
            name: _productNameController.text,
            price: double.tryParse(_priceController.text) ?? 0.0,
            unit: selectedUnit,
            category: selectedCategory,
            description: _descriptionController.text,
          ),
        );
      } else {
        context.read<ItemProvider>().updateItemCard(
          Item(
            id: widget.item!.id,
            name: _productNameController.text,
            price: double.tryParse(_priceController.text) ?? 0.0,
            unit: selectedUnit,
            category: selectedCategory,
            description: _descriptionController.text,
          ),
        );
      }
      // After saving, you probably want to close the page
      Navigator.of(context).pop();
    } else {
      if (kDebugMode) {
        print("Item form is not valid");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew && widget.item != null) {
      _productNameController.text = widget.item!.name;
      _priceController.text = widget.item!.price.toString();
      selectedUnit = widget.item!.unit;
      selectedCategory = widget.item!.category;
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextFormField(
                    title: "Product Name",
                    inputController: _productNameController,
                  ),
                  SizedBox(height: 10),
                  InputTextField(
                    title: "Price",
                    inputController: _priceController,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  CustomDropdownMenu(
                    title: "Unit",
                    dropDownList: context
                        .read<ItemProvider>()
                        .unitList
                        .entries
                        .map((entry) {
                          return DropdownMenuEntry(
                            value:
                                entry.key, // Use the map key (int) as the value
                            label: entry
                                .value, // Use the map value (String) as the label
                          );
                        })
                        .toList(),
                    initialSelection: selectedUnit,
                    onSelected: (selectedValue) {
                      if (selectedValue != null) {
                        setState(() {
                          // The callback gives you the VALUE (the int)
                          selectedUnit = selectedValue as int;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  // InputTextField(title: "Barcode"),
                  // SizedBox(height: 10),
                  CustomDropdownMenu(
                    title: "Category",
                    dropDownList: context
                        .read<ItemProvider>()
                        .categoryList
                        .entries
                        .map((entry) {
                          return DropdownMenuEntry(
                            value:
                                entry.key, // Use the map key (int) as the value
                            label: entry
                                .value, // Use the map value (String) as the label
                          );
                        })
                        .toList(),
                    initialSelection: selectedCategory,
                    onSelected: (selectedValue) {
                      if (selectedValue != null) {
                        setState(() {
                          // The callback gives you the VALUE (the int)
                          selectedCategory = selectedValue as int;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  InputTextField(
                    title: "Description",
                    inputController: _descriptionController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
