import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/notes_model.dart';
import 'package:fire_auth/screens/home/widget/custom_app_bar.dart';
import 'package:fire_auth/screens/home/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String title = "";

  String subTitle = "";

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:
          context.watch<UserCubit>().state.formsStatus != FormsStatus.loading,
      child: Scaffold(
        appBar: CustomAppBar(title: "Add Notes"),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              TextFormField(
                onChanged: (v) => setState(() {
                  title = v;
                }),
                decoration: InputDecoration(hintText: "Inter title.."),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (v) => setState(() {
                  subTitle = v;
                }),
                decoration: InputDecoration(hintText: "Inter sub title.."),
              ),
              SizedBox(height: 50),
              SubmitButton(
                isLoading: context.watch<UserCubit>().state.formsStatus ==
                    FormsStatus.loading,
                isActiveButton: checkInput,
                onTab: () {
                  FocusScope.of(context).unfocus();
                  context.read<UserCubit>().saveNotes(
                        notesModel: NotesModel(
                          subTitle: subTitle,
                          title: title,
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get checkInput {
    return title.isNotEmpty && subTitle.isNotEmpty;
  }
}
