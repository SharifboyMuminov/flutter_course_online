import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/notes_model.dart';
import 'package:fire_auth/screens/home/widget/custom_app_bar.dart';
import 'package:fire_auth/screens/home/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNotes extends StatefulWidget {
  const UpdateNotes({
    super.key,
    required this.notesModel,
    required this.indexNotesModel,
  });

  final NotesModel notesModel;
  final int indexNotesModel;

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerSubTitle = TextEditingController();

  @override
  void initState() {
    _controllerTitle.text = widget.notesModel.title;
    _controllerSubTitle.text = widget.notesModel.subTitle;
    super.initState();
  }

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
                controller: _controllerTitle,
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(hintText: "Inter title.."),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _controllerSubTitle,
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(hintText: "Inter sub title.."),
              ),
              SizedBox(height: 50),
              SubmitButton(
                isLoading: context.watch<UserCubit>().state.formsStatus ==
                    FormsStatus.loading,
                isActiveButton: checkInput,
                onTab: () {
                  FocusScope.of(context).unfocus();
                  context.read<UserCubit>().updateNotes(
                      notesModel: NotesModel(
                        subTitle: _controllerSubTitle.text,
                        title: _controllerTitle.text,
                      ),
                      indexNotesModel: widget.indexNotesModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get checkInput {
    return _controllerTitle.text.isNotEmpty &&
        _controllerSubTitle.text.isNotEmpty &&
        (_controllerSubTitle.text != widget.notesModel.subTitle ||
            _controllerTitle.text != widget.notesModel.title);
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerSubTitle.dispose();
    super.dispose();
  }
}
