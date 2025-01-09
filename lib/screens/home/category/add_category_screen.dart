import 'package:fire_auth/cubits/category/category_cubit.dart';
import 'package:fire_auth/cubits/category/category_state.dart';
import 'package:fire_auth/cubits/home/home_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/model/category_model.dart';
import 'package:fire_auth/screens/home/widget/costume_button.dart';
import 'package:fire_auth/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String imageUrl = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              children: [
                if (imageUrl.isNotEmpty)
                  SizedBox(
                    width: width,
                    height: 200,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                TextFormField(
                  onChanged: (v) {
                    setState(() {
                      imageUrl = v;
                    });
                  },
                  decoration: InputDecoration(hintText: "Enter image url..."),
                ),
                20.getH(),
                TextFormField(
                  onChanged: (v) {
                    setState(() {
                      categoryName = v;
                    });
                  },
                  decoration:
                      InputDecoration(hintText: "Enter category name..."),
                ),
                30.getH(),
                CostumeButton(
                  icLoader: state.formsStatus == FormsStatus.loading,
                  isActive: checkInput(),
                  onTab: () {
                    context.read<CategoryCubit>().addCategory(
                          categoryModel: CategoryModel(
                            imageUrl: imageUrl,
                            title: categoryName,
                            categoryId: "",
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state.statusMessage == "pop") {
            context.read<HomeCubit>().getCategories();
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool checkInput() {
    return imageUrl.isNotEmpty && categoryName.isNotEmpty;
  }
}
