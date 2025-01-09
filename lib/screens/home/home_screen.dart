import 'package:fire_auth/cubits/home/home_cubit.dart';
import 'package:fire_auth/cubits/home/home_state.dart';
import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/screens/home/category/add_category_screen.dart';
import 'package:fire_auth/screens/home/product/add_product_screen.dart';
import 'package:fire_auth/screens/home/widget/category_item.dart';
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
      context.read<HomeCubit>().getCategories();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddCategoryScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.category,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddProductScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          if (state.formsStatus == FormsStatus.loading) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(state.categories.length, (index) {
                      return CategoryItem(
                        onTab: () {},
                        categoryModel: state.categories[index],
                      );
                    }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverGrid.builder(
                itemCount: state.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(
                      left: index.isEven ? 15 : 0,
                      right: index.isOdd ? 15 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              state.products[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(state.products[index].title),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
