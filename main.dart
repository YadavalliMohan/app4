import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _email;
  String? _password;

  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Here you can implement the login functionality.
      // For now, we will just print the credentials.
      print("Email: $_email");
      print("Password: $_password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Input
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Email validation regex
                  final regex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: 16.0),

              // Password Input
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(height: 20.0),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),

              SizedBox(height: 20.0),

              // Register Option
              TextButton(
                onPressed: () {
                  // Navigate to registration page or show a dialog
                  print('Navigate to Register');
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
