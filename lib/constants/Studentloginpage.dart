import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late Future<String?> greetingText;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    super.initState();
    greetingText = fetchGreetingText();
  }

  Future<String?> fetchGreetingText() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('greeting')
          .doc('greetingDocument')
          .get();
      return snapshot['text'];
    } catch (e) {
      print('Error fetching greeting text: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          'User Login',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Card(
              color: const Color.fromARGB(0, 233, 227, 227),
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<String?>(
                      future: greetingText,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError || snapshot.data == null) {
                          return const SizedBox.shrink();
                        } else {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "User Login",
                        style: TextStyle(fontSize: 24, color: Colors.amber),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    InkWell(
                      onTap: () async {
                        try {
                          await _googleSignIn.signIn();
                          GoogleSignInAccount? user = _googleSignIn.currentUser;

                          if (user != null) {
                            await FirebaseFirestore.instance
                                .collection('studentuserCollection')
                                .add({
                              'email': user.email,
                            });

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            print('Google Sign-In failed');
                          }
                        } catch (error) {
                          print('Google Sign-In error: $error');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sign in with ",
                            style: TextStyle(fontSize: 24, color: Colors.amber),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset("assets/google.png"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
