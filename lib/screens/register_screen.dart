import 'package:demo_app/screens/signin_screen.dart';
import 'package:demo_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.toggleView});
  final VoidCallback toggleView;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey =
      GlobalKey<
        FormState
      >(); // Create a GlobalKey to identify the form and validate it later.
  bool hidePassword = true;
  String userName = '';
  String email = '';
  String password = '';
  bool? checkBoxValue = false;
  final AuthService _auth =
      AuthService(); // Create an instance of AuthService to handle authentication operations
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
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
                    Image.asset(
                      "assets/images/todo.png",
                      height: size.height * 0.08,
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
                        fontSize: 26,

                        fontWeight: FontWeight.bold,

                        color: const Color(0xFF000000),

                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      "Sign-up  to get Started and get the best \n from our app",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
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
                        ///USERNAME FIELD
                        TextFormField(
  decoration: InputDecoration(
    labelText: "Username",
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return "Enter username";
    }
    return null;
  },
  onChanged: (value) {
    setState(() {
      userName = value;
    });
  },
),
SizedBox(height: 20),
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
                              activeColor: Colors.green[700],
                              value: checkBoxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxValue = value;
                                }); // Trigger a rebuild to reflect the change
                                // Handle checkbox state change if needed
                              },
                            ),
                            Text(
                              "I have read and accept the ",
                              style: TextStyle(
                                color: Colors.grey[700],
                                wordSpacing: 2,
                              ),
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ],
                        ),

                        Container(
                          width: 300,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),

                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic user = await _auth
                                    .registerWithEmailAndPass(userName,email, password);

                                if (user != null) {
                                  print("Register success");
                                  // No Navigator.push needed
                                  // StreamProvider will detect change → Wrapper rebuilds → HomeScreen
                                } else {
                                  print("Error registering user");
                                }
                              }
                            },

                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I'm already a member!",
                              style: TextStyle(color: const Color(0xFF000000)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (_) => SigninScreen(
                                          toggleView: widget.toggleView,
                                        ),
                                      ),
                                    )
                                    .then(
                                      (_) => widget.toggleView(),
                                    ); // ✅ correct
                              },
                              child: Text("Sign in"),
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
