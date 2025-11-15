import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice_app/providers/business_provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/widgets/text_field.dart';
import '../../../../models/business.dart';
import '../../../../styles/colors.dart';

class AddBusiness extends StatefulWidget {
  final bool isNew;
  final Business? business;
  final BuildContext? context;
  const AddBusiness({
    super.key,
    this.context,
    this.business,
    this.isNew = true,
  });

  @override
  State<AddBusiness> createState() => _AddBusinessState();
}

class _AddBusinessState extends State<AddBusiness> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _paymentInfoController = TextEditingController();
  final _paypalEmailController = TextEditingController();

  bool isSaveButtonPressed = false;

  void saveBusiness() {
    isSaveButtonPressed = true;
    if (_formKey.currentState!.validate()) {
      if (widget.isNew) {
        context.read<BusinessProvider>().addBusiness(
          Business(
            name: _businessNameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
            website: _websiteController.text,
            paymentInfo: _paymentInfoController.text,
            paypalEmail: _paypalEmailController.text,
          ),
        );
      } else {
        context.read<BusinessProvider>().updateBusiness(
          Business(
            id: widget.business!.id,
            name: _businessNameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            address: _addressController.text,
            website: _websiteController.text,
            paymentInfo: _paymentInfoController.text,
            paypalEmail: _paypalEmailController.text,
            totalMoney: widget.business!.totalMoney,
            invoiceCount: widget.business!.invoiceCount,
          ),
        );
      }
      // After saving, you probably want to close the page
      Navigator.of(context).pop();
    } else {
      if (kDebugMode) {
        print("Business form is not valid");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isNew && widget.business != null) {
      _businessNameController.text = widget.business!.name;
      _emailController.text = widget.business!.email;
      _phoneController.text = widget.business!.phone;
      _addressController.text = widget.business!.address;
      _websiteController.text = widget.business!.website;
      _paymentInfoController.text = widget.business!.paymentInfo;
      _paypalEmailController.text = widget.business!.paypalEmail;
    }

    _businessNameController.addListener(() {
      if (isSaveButtonPressed) {
        setState(() {
          _formKey.currentState!.validate();
        });
      }
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _paymentInfoController.dispose();
    _paypalEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Manage your businesses',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: saveBusiness,
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
                // Logo
                DottedBorder(
                  options: const RectDottedBorderOptions(
                    color: Color(0xFFAAA4A4),
                    dashPattern: [6, 4],
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text("+", style: TextStyle(fontSize: 24, height: 0),), Text("LOGO")],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InputTextFormField(
                  title: "Business Name",
                  inputController: _businessNameController,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Address",
                  inputController: _addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
            
                SizedBox(height: 10),
                InputTextField(
                  title: "Email",
                  inputController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
            
                SizedBox(height: 10),
                InputTextField(
                  title: "Phone",
                  inputController: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Website",
                  inputController: _websiteController,
                ),
                SizedBox(height: 10),
                Container(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    "Payment Info",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Payment Info",
                  inputController: _paymentInfoController,
                ),
                SizedBox(height: 10),
                InputTextField(
                  title: "Paypal email",
                  inputController: _paypalEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                // OR Code
                Container(
                  alignment: Alignment.centerLeft,
                  child: DottedBorder(
                    options: const RectDottedBorderOptions(
                      color: Color(0xFFAAA4A4),
                      dashPattern: [6, 4],
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text("+", style: TextStyle(fontSize: 24, height: 0),), Text("QR Pay")],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Add default signature",
                    style: TextStyle(
                      color: AppColor.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  alignment: Alignment.centerLeft,

                  child: DottedBorder(
                    options: const RectDottedBorderOptions(
                      color: Color(0xFFAAA4A4),
                      dashPattern: [6, 4],
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 250,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text("+", style: TextStyle(fontSize: 24, height: 0),), Text("Add default signature")],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
