import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/cubits/user/user_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<UserCubit>().fetchUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return Center(
            child: Text(
              state.userModel.email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    );
  }
}
