import 'package:demo_app/screens/register_screen.dart';
import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key, required this.toggleView});
  final Function toggleView;


  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool hidePassword = true;
  final AuthService _auth =
      AuthService(); // Create an instance of AuthService to handle authentication operations
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

                    // Text(
                    //   "Brew Crew",

                    //   style: TextStyle(
                    //     fontSize: 32,

                    //     fontWeight: FontWeight.bold,

                    //     color: Colors.brown,

                    //     letterSpacing: 2,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Text(
                "Welcome back!",

                style: TextStyle(
                  fontSize: 30,

                  fontWeight: FontWeight.bold,

                  color: Colors.brown,

                  letterSpacing: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Sign up to get started and get the best \nfrom our app",
                  style: TextStyle(
                    color: Colors.brown[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
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

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),

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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.brown,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.brown,
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// LOGIN BUTTON
                        Container(
                          width: 300,
                          child: ElevatedButton(
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
                              "Continue",
                              style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(toggleView: widget.toggleView,),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(color: Colors.brown),
                              ),
                            ),
                          ],
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
