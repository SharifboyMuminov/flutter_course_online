import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/cubits/user/user_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/screens/home/add_notes_screen.dart';
import 'package:fire_auth/screens/home/update_notes_screen.dart';
import 'package:fire_auth/screens/home/widget/custom_app_bar.dart';
import 'package:fire_auth/screens/home/widget/home_item.dart';
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
      appBar: CustomAppBar(title: "Notes App"),
      body: BlocConsumer<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.userModel.userNotes.isEmpty) {
            return const Center(
                child: Text("Empty Notes", style: TextStyle(fontSize: 30)));
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: state.userModel.userNotes.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeItem(
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UpdateNotes(
                          notesModel: state.userModel.userNotes[index],
                          indexNotesModel: index,
                        );
                      },
                    ),
                  );
                },
                title: state.userModel.userNotes[index].title,
              );
            },
          );
        },
        listener: (BuildContext context, state) {
          if (state.statusMessage == "pop") {
            Navigator.pop(context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNotes();
              },
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
