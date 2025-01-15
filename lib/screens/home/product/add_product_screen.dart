import 'package:fire_auth/cubits/home/home_cubit.dart';
import 'package:fire_auth/cubits/product/product_cubit.dart';
import 'package:fire_auth/cubits/product/product_state.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/model/category_model.dart';
import 'package:fire_auth/data/model/product_model.dart';
import 'package:fire_auth/screens/home/widget/costume_button.dart';
import 'package:fire_auth/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.onFetch});
  final VoidCallback onFetch;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String imageUrl = "";
  String productName = "";
  String price = "";
  String about = "";
  CategoryModel? categoryModel;

  final ExpansionTileController _expansionTileController =
      ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = context.read<HomeCubit>().state.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
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
                      productName = v;
                    });
                  },
                  decoration:
                      InputDecoration(hintText: "Enter product name..."),
                ),
                20.getH(),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    setState(() {
                      price = v;
                    });
                  },
                  decoration:
                      InputDecoration(hintText: "Enter product price..."),
                ),
                20.getH(),
                TextFormField(
                  onChanged: (v) {
                    setState(() {
                      about = v;
                    });
                  },
                  decoration:
                      InputDecoration(hintText: "Enter product about..."),
                ),
                ExpansionTile(
                  controller: _expansionTileController,
                  title: Text(categoryModel?.title ?? "Select Category"),
                  children: List.generate(categories.length, (index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          categoryModel = categories[index];
                        });
                        _expansionTileController.collapse();
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(categories[index].imageUrl),
                      ),
                      title: Text(categories[index].title),
                    );
                  }),
                ),
                30.getH(),
                CostumeButton(
                  icLoader: state.formsStatus == FormsStatus.loading,
                  isActive: checkInput(),
                  onTab: () {
                    String userId = StorageRepository.getString(key: "user_id");
                    ProductModel productModel = ProductModel(
                      imageUrl: imageUrl,
                      title: productName,
                      categoryId: categoryModel?.categoryId ?? "",
                      id: "",
                      about: about,
                      adminId: userId,
                    );
                    context
                        .read<ProductCubit>()
                        .addProduct(productModel: productModel);
                  },
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state.statusMessage == "pop") {
            widget.onFetch.call();
            context.read<HomeCubit>().getCategories();
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool checkInput() {
    return imageUrl.isNotEmpty &&
        productName.isNotEmpty &&
        price.isNotEmpty &&
        about.isNotEmpty &&
        categoryModel != null;
  }
}
