import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Committee extends StatefulWidget {
  const Committee({Key? key});

  @override
  State<Committee> createState() => _CommitteeState();
}

class _CommitteeState extends State<Committee> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? _hostelliteOption;

  void _submitData() async {
    // Validate input data
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _hostelliteOption == null) {
      // Show an error message if any field is empty
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    // Validate phone number
    String phoneNumber = _phoneNumberController.text;
    if (phoneNumber.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      _showErrorDialog("Please enter a valid 10-digit phone number.");
      return;
    }

    // Collect data and add to Firebase Cloud Firestore
    await FirebaseFirestore.instance.collection('committeeData').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'phoneNumber': phoneNumber,
      'isHostellite': _hostelliteOption,
    });

    // Clear text fields after submitting data
    _nameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _hostelliteOption = null;

    // Show a success message
    _showSuccessDialog(
        "We have received your message, we will contact you soon.");
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Contact Mess Committee"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_cooption.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField("Name", _nameController),
              _buildTextField("Email", _emailController),
              _buildTextField("Phone Number", _phoneNumberController),
              _buildRadioButtons(),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    TextInputType keyboardType = TextInputType.text;
    List<TextInputFormatter> inputFormatters = [];

    if (label == "Phone Number") {
      keyboardType = TextInputType.number;
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRadioButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you a hostellite?',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Radio(
                value: 'Yes',
                groupValue: _hostelliteOption,
                onChanged: (value) {
                  setState(() {
                    _hostelliteOption = value.toString();
                  });
                },
              ),
              Text('Yes'),
              Radio(
                value: 'No',
                groupValue: _hostelliteOption,
                onChanged: (value) {
                  setState(() {
                    _hostelliteOption = value.toString();
                  });
                },
              ),
              Text('No'),
            ],
          ),
        ],
      ),
    );
  }
}
