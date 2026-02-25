import 'dart:ffi';

import 'package:demo_app/screens/signin_screen.dart';
import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.toggleView});
  final Function toggleView;
  

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();// Create a GlobalKey to identify the form and validate it later.
  bool hidePassword = true;
  String email = '';
  String password = '';
  final  AuthService _auth = AuthService();// Create an instance of AuthService to handle authentication operations
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
                    Text(
                      "Create an Account",

                      style: TextStyle(
                        fontSize: 32,

                        fontWeight: FontWeight.bold,

                        color: Colors.brown,

                        letterSpacing: 2,
                      ),
                    ),
                    Text("Sign up to get started and get the best \nfrom our app",style: TextStyle(color: Colors.brown[700],fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ],
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

                        SizedBox(height: 20),
                         
                        Row(

                           children: [
                            Checkbox(
                              activeColor: Colors.brown,
                              value: true,
                              onChanged: (value) {
                                // Handle checkbox state change if needed
                              },
                            ),
                            Text("I have read and accept the ",
                            style: TextStyle(color: Colors.grey[700],wordSpacing: 2),),
                            Text("Privacy Policy",
                            style: TextStyle(color: Colors.brown,),)
                           ],
                        ),

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
                              "Sign up",
                              style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold,fontSize: 17,letterSpacing: 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("I'm already a member!",style: TextStyle(color: Colors.brown[700],fontWeight: FontWeight.bold),),
                              TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen(toggleView: widget.toggleView)));
                        }, child: Text("Sign in",style: TextStyle(color: Colors.brown,))

                      
                         ) ],
                    ),
             ] ),
                ),
              ),
           ) ],
          ),
        ),
      ),
    );
  }
}


