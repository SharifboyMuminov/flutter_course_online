import 'package:fire_auth/cubits/auth/auth_cubit.dart';
import 'package:fire_auth/cubits/auth/auth_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                SizedBox(height: 150),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _controllerPhoneNumber,
                  decoration: InputDecoration(hintText: "Inter phone number.."),
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
                          phoneNumber: _controllerPhoneNumber.text,
                          password: _controllerPassword.text,
                        );
                  },
                  child: context.watch<AuthCubit>().state.formsStatus ==
                          FormsStatus.loading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state.formsStatus == FormsStatus.authenticated) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          } else if (state.formsStatus == FormsStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.errorText,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
