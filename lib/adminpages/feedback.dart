import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TakeInput extends StatefulWidget {
  const TakeInput({Key? key}) : super(key: key);

  @override
  State<TakeInput> createState() => _TakeInputState();
}

class _TakeInputState extends State<TakeInput> {
  late Future<FirebaseApp> _initialization;
  late CollectionReference _feedbackData;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
    _feedbackData = FirebaseFirestore.instance.collection('feedbackData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedbacks"),
        backgroundColor: Color.fromARGB(255, 243, 36, 36),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/background_cooption.jpg', // Set your background image asset
            fit: BoxFit.cover,
          ),
          // Content
          FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return StreamBuilder(
                  stream: _feedbackData.snapshots(),
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

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (DocumentSnapshot document
                                in snapshot.data!.docs)
                              _buildFeedbackTile(document),
                          ],
                        ),
                      ),
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackTile(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Color.fromARGB(255, 231, 235, 238), // Set your desired card color
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
            Text("Feedback = ${data['feedback']}"),
          ],
        ),
        // You can add more widgets to display additional data
      ),
    );
  }
}
