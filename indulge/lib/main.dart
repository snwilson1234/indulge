import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Login()
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: Text("Login")
            ),
            const Expanded(
              flex: 2,
              child: LoginForm(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Text("Don't have an account with us? Sign up below."),
                  OutlinedButton(
                    onPressed: () {
                      print("pressed Sign Up");
                    }, 
                    child: const Text("Sign Up")
                  ),
                ],
              )
            ),
          ],
      ),
      )
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  // global key that uniquely identifies the Form widget
  // and allows validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // USERNAME FIELD
            ConstrainedBox(
              constraints: BoxConstraints.loose(
                const Size(300, 50)
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your username here.',
                labelText: 'Username *',
                
              ),
                validator: (String? value) {
                  return (value != null) ? 'Required field' : null;
                }
              ),
            ),
            // PASSWORD FIELD
            ConstrainedBox(
              constraints: BoxConstraints.loose(
                const Size(300, 50)
              ),
              child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter your password here.',
                    labelText: 'Password *',
                  ),
                  validator: (String? value) {
                    return (value != null) ? 'Required field' : null;
                  }
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)
              ),
              onPressed: () {
                print("pressed login");
              }, 
              child: Text("Login")
            ),
          ],    
        ),
      ),
    );
  }
}