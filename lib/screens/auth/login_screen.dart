import 'package:fire_auth/cubits/auth/auth_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            SizedBox(height: 150),
            Text("Login"),
            SizedBox(height: 20),
            TextFormField(
              controller: _controllerEmail,
              decoration: InputDecoration(hintText: "Inter email.."),
            ),
            SizedBox(height: 50),
            TextFormField(
              controller: _controllerPassword,
              decoration: InputDecoration(hintText: "Inter password.."),
            ),
            SizedBox(height: 150),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                context.read<AuthCubit>().loginUser(
                      email: _controllerEmail.text,
                      password: _controllerPassword.text,
                    );
              },
              child: context.watch<AuthCubit>().state.formsStatus ==
                      FormsStatus.loading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
