// ignore_for_file: unused_local_variable, unused_field, use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proje1/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SignUpApp());
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color.fromARGB(255, 177, 173, 173),
      ),
      backgroundColor: const Color.fromARGB(255, 167, 162, 162),
      body: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _passwordError;

  bool _validatePassword(String password) {
    // Updated regex pattern for better special character handling
    String pattern = r'^(?=.*[A-Z])(?=.*[!@#\$&*~]).{6,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/XOX.png",
            width: 200,
            height: 180,
          ),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: _passwordError,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              String username = _usernameController.text;
              String email = _emailController.text;
              String password = _passwordController.text;

              setState(() {
                if (password.isEmpty) {
                  _passwordError = 'Password field is required.';
                } else if (!_validatePassword(password)) {
                  _passwordError =
                      'Password must be at least 6 characters long, include an uppercase letter and a special character.';
                } else {
                  _passwordError = null;
                }
              });

              if (username.isEmpty || email.isEmpty || _passwordError != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Try Again'),
                      content: const Text(
                          'Username, email, and password cannot be empty, and password must meet the criteria.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                try {
                  // User registration
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);

                  // Save user information to Firestore
                  await AuthService().registerUser(
                    username: username,
                    email: email,
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Successful'),
                        content: const Text(
                            'Your account has been created successfully.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } on FirebaseAuthException catch (e) {
                  // Handle specific Firebase exceptions
                  String errorMessage;
                  if (e.code == 'email-already-in-use') {
                    errorMessage = 'E-mail already in use.';
                  } else if (e.code == 'invalid-email') {
                    errorMessage = 'Invalid email address.';
                  } else if (e.code == 'operation-not-allowed') {
                    errorMessage = 'Email/password accounts are not enabled.';
                  } else if (e.code == 'weak-password') {
                    errorMessage = 'Password is too weak.';
                  } else {
                    errorMessage = 'An error occurred. Please try again.';
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Try Again'),
                        content: Text(errorMessage),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print('Error: $e');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              minimumSize: const Size(150, 50),
              foregroundColor: const Color.fromARGB(255, 0, 0, 0),
              backgroundColor: const Color.fromARGB(255, 234, 226, 226),
            ),
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> registerUser({
    required String username,
    required String email,
  }) async {
    await _usersCollection.doc().set({
      'username': username,
      'email': email,
    });
  }
}
