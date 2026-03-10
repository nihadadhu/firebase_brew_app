
import 'package:flutter/material.dart';
import 'package:demo_app/services/auth_service.dart';

class SigninScreen extends StatefulWidget {
const SigninScreen({super.key, required this.toggleView});

final VoidCallback toggleView;

@override
State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

final _formKey = GlobalKey<FormState>();
final AuthService _auth = AuthService();

String email = '';
String password = '';

bool hidePassword = true;
bool isLoading = false;

Future<void> login() async {


if (!_formKey.currentState!.validate()) return;

setState(() {
  isLoading = true;
});

final user = await _auth.signInWithEmailAndPass(email, password);

if (!mounted) return;

setState(() {
  isLoading = false;
});

if (user == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Login failed")),
  );
} else {
  debugPrint("Login success");
  // Navigation handled by Wrapper / Auth Stream
}


}

@override
Widget build(BuildContext context) {


final size = MediaQuery.of(context).size;

return Scaffold(
  backgroundColor: Colors.white,

  body: SafeArea(
    child: SingleChildScrollView(

      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: 20,
      ),

      child: Form(
        key: _formKey,

        child: Column(
          children: [

            const SizedBox(height: 20),

            Image.asset(
              "assets/images/todo.png",
              height: size.height * 0.08,
            ),

            const SizedBox(height: 20),

            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Login to continue and enjoy the app",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            TextFormField(
              decoration: _inputDecoration(
                label: "Email",
                icon: Icons.email,
              ),
              validator: (value) =>
                  value!.isEmpty ? "Enter email" : null,
              onChanged: (value) => email = value,
            ),

            const SizedBox(height: 20),

            TextFormField(
              obscureText: hidePassword,

              decoration: _inputDecoration(
                label: "Password",
                icon: Icons.lock,
                suffix: IconButton(
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

              validator: (value) =>
                  value!.length < 6 ? "Enter 6+ characters" : null,

              onChanged: (value) => password = value,
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: isLoading ? null : login,

                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or login with",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 25),

            _socialButton(
              text: "Sign in with Google",
              image: "assets/images/google.png",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            _socialButton(
              text: "Sign in with Apple",
              icon: Icons.apple,
              onTap: () {},
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text("Don't have an account? "),

                TextButton(
                  onPressed: () {
                  widget.toggleView();
                  },
                  child: const Text("Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
);


}

InputDecoration _inputDecoration({
required String label,
required IconData icon,
Widget? suffix,
}) {
return InputDecoration(
labelText: label,
prefixIcon: Icon(icon),
suffixIcon: suffix,
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
);
}

Widget _socialButton({
required String text,
String? image,
IconData? icon,
required VoidCallback onTap,
}) {
return SizedBox(
width: double.infinity,
height: 50,
child: OutlinedButton.icon(
style: OutlinedButton.styleFrom(
side: const BorderSide(color: Colors.grey),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
),
),
onPressed: onTap,
icon: image != null
? Image.asset(image, height: 22)
: Icon(icon, color: Colors.black),
label: Text(
text,
style: const TextStyle(
color: Colors.black87,
fontWeight: FontWeight.w600,
),
),
),
);
}
}
