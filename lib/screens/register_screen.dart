import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String email = '';
  String password = '';
  final  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        // appBar: AppBar(
        //   backgroundColor: Colors.brown[400],
        //   elevation: 0.0,
        //   title: Text(" Brew Crew"),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Hero(
                      tag: "coffee",

                      child: Icon(Icons.coffee, size: 100, color: Colors.brown),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Brew Crew",

                      style: TextStyle(
                        fontSize: 32,

                        fontWeight: FontWeight.bold,

                        color: Colors.brown,

                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        /// EMAIL FIELD
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",

                            prefixIcon: Icon(Icons.email),

                            border: OutlineInputBorder(),
                          ),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            }

                            return null;
                          },

                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),

                        SizedBox(height: 20),

                        /// PASSWORD FIELD
                        TextFormField(
                          obscureText: hidePassword,

                          decoration: InputDecoration(
                            labelText: "Password",

                            prefixIcon: Icon(Icons.lock),

                            border: OutlineInputBorder(),

                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),

                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value!.length < 6) {
                              return "Enter 6+ characters";
                            }

                            return null;
                          },

                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),

                        SizedBox(height: 20),

                        /// LOGIN BUTTON
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),

                          onPressed: () async {
                            // await _auth.signinAnon();
                            if (_formKey.currentState!.validate()) {
                              print(email);
                              print(password);
                            }
                          },

                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
