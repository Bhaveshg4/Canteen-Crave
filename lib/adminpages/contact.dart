import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSecureAdmin extends StatefulWidget {
  const ContactSecureAdmin({Key? key}) : super(key: key);

  @override
  State<ContactSecureAdmin> createState() => _ContactSecureAdminState();
}

class _ContactSecureAdminState extends State<ContactSecureAdmin> {
  late Future<FirebaseApp> _initialization;
  late CollectionReference _committeeData;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
    _committeeData = FirebaseFirestore.instance.collection('committeeData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 243, 36, 36),
        title: const Text("Contact"),
      ),
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: _committeeData.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    Image.asset(
                      'assets/background_cooption.jpg',
                      fit: BoxFit.cover,
                    ),
                    // Content
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (DocumentSnapshot document
                                in snapshot.data!.docs)
                              _buildCommitteeMemberTile(document),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error initializing Firebase: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            // Handle the case where the initialization is not yet complete
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildCommitteeMemberTile(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.lightGreenAccent, // Set your desired card color
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          "Name = ${data['name']}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email = ${data['email']}"),
            Text("Phone Number = ${data['phoneNumber']}"),
            Text("Is Hostellite = ${data['isHostellite']}"),
          ],
        ),
        // You can add more widgets to display additional data
      ),
    );
  }
}
