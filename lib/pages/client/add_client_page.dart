import 'package:flutter/material.dart';

import '../../common/widgets/custom_dropdown.dart';
import '../../common/widgets/text_field.dart';
import '../../styles/colors.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();

  bool isSaveButtonPressed = false;

  void saveClient() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      String clientName = _clientNameController.text;
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
    isSaveButtonPressed = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Add new Client',
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
          child: Column(
            children: [
              InputTextFormField(
                title: "Client Name",
                inputController: _clientNameController,
              ),
              SizedBox(height: 10),
              InputTextField(title: "Email"),
              SizedBox(height: 10),
              InputTextField(title: "Phone Number"),
              SizedBox(height: 10),
              InputTextField(title: "Address"),
              SizedBox(height: 10),
              CustomDropdownMenu(
                title: "Customer Classification",
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
