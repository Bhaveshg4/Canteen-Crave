import 'package:flutter/material.dart';

class AddThaliAdmin extends StatefulWidget {
  const AddThaliAdmin({super.key});

  @override
  State<AddThaliAdmin> createState() => _AddThaliAdminState();
}

class _AddThaliAdminState extends State<AddThaliAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Thali Requests"),
      ),
    );
  }
}
