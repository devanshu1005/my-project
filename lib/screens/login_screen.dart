import 'package:flutter/material.dart';
import 'package:my_project/resources/auth_methods.dart';
import 'package:my_project/screens/feed_screen.dart';
import 'package:my_project/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  Future<void> loginUser() async {
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passController.text,
    );

    if (res == "success") {
      // Navigate to FeedScreen when login is successful
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FeedScreen()),
      );
    } else {
      // Handle login failure
      // You can show an error message or take appropriate action here
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
              obscureText: true, // Hide password text
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to SignupScreen when "Sign up" is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Sign up.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
