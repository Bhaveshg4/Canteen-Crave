import 'package:flutter/material.dart';

class AddThali extends StatefulWidget {
  const AddThali({super.key});

  @override
  State<AddThali> createState() => _AddThaliState();
}

class _AddThaliState extends State<AddThali> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Additional Thali"),
      ),
    );
  }
}
