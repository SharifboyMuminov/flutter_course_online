import 'package:fire_auth/screens/home/widget/costume_button.dart';
import 'package:fire_auth/utils/app_size.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
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
              decoration: InputDecoration(hintText: "Enter category name..."),
            ),
            30.getH(),
            CostumeButton(
              isActive: checkInput(),
              onTab: () {},
            ),
          ],
        ),
      ),
    );
  }

  bool checkInput() {
    return imageUrl.isNotEmpty && categoryName.isNotEmpty;
  }
}
