import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddThaliAdmin extends StatefulWidget {
  const AddThaliAdmin({Key? key}) : super(key: key);

  @override
  State<AddThaliAdmin> createState() => _AddThaliAdminState();
}

class _AddThaliAdminState extends State<AddThaliAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Additional Thali Requests"),
        backgroundColor: Colors.redAccent, // Set your preferred app bar color
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background_cooption.jpg', // Set your background image asset
              fit: BoxFit.cover,
            ),
          ),
          // Content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('AddThaliInfo')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors
                        .redAccent, // Set your preferred loading indicator color
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              }

              // Process the data
              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              // You can now use the 'documents' list to display the data as needed

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(
                        'Name: ${document['name']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text('Phone: ${document['phoneNumber']}'),
                          Text('Room: ${document['roomNumber']}'),
                          Text('Email: ${document['email']}'),
                          Text('Hostellite: ${document['isHostellite']}'),
                          Text('Thalis: ${document['numberOfThalis']}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
