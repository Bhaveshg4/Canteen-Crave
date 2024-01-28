import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddThali extends StatefulWidget {
  const AddThali({Key? key}) : super(key: key);

  @override
  _AddThaliState createState() => _AddThaliState();
}

class _AddThaliState extends State<AddThali> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberOfThalisController =
      TextEditingController();

  bool _isHostellite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Additional Thali"),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_cooption.jpg'), // Set your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildRadioContainer(
                    child: Row(
                      children: [
                        Text("Are you Hostellite?: "),
                        Radio(
                          value: true,
                          groupValue: _isHostellite,
                          onChanged: (value) {
                            setState(() {
                              _isHostellite = value as bool;
                            });
                          },
                        ),
                        Text("Yes"),
                        Radio(
                          value: false,
                          groupValue: _isHostellite,
                          onChanged: (value) {
                            setState(() {
                              _isHostellite = value as bool;
                            });
                          },
                        ),
                        Text("No"),
                      ],
                    ),
                  ),
                  if (_isHostellite) // Show only if a hostellite
                    _buildTextFieldContainer(
                      child: TextFormField(
                        controller: _roomNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Room Number',
                          labelStyle: TextStyle(fontSize: 18.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your room number';
                          }
                          return null;
                        },
                      ),
                    ),
                  _buildTextFieldContainer(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 18.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  _buildTextFieldContainer(
                    child: TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(fontSize: 18.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  _buildTextFieldContainer(
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 18.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  _buildTextFieldContainer(
                    child: TextFormField(
                      controller: _numberOfThalisController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'How many thalis?',
                        labelStyle: TextStyle(fontSize: 18.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of thalis';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All form fields are valid, send data to Firebase
                        _addToFirebase();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  Widget _buildRadioContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  void _addToFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('AddThaliInfo').add({
        'name': _nameController.text,
        'phoneNumber': _phoneNumberController.text,
        'roomNumber': _roomNumberController.text,
        'email': _emailController.text,
        'isHostellite': _isHostellite,
        'numberOfThalis': int.parse(_numberOfThalisController.text),
      });

      // Clear the form after successful submission
      _formKey.currentState!.reset();

      // Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Your request has been send, please go mess and take your order!'),
          duration: Duration(seconds: 4),
        ),
      );
    } catch (e) {
      print('Error adding data to Firebase: $e');
    }
  }
}
