import 'package:fire_auth/cubits/home/home_cubit.dart';
import 'package:fire_auth/cubits/home/home_state.dart';
import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/data/enums/forms_status.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
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
  int _activeIndexCategory = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Future.microtask(() {
      context.read<UserCubit>().fetchUser();
      context.read<HomeCubit>().getCategories();
    });
    _scrollToTop();

    super.initState();
  }

  void _scrollToTop() {
    int lengthCafes = context.read<HomeCubit>().state.categories.length;
    if (_activeIndexCategory >= 0 && _activeIndexCategory < (lengthCafes)) {
      _scrollController.animateTo(
        (100) * _activeIndexCategory.toDouble(),
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
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
                    return AddProductScreen(onFetch: () {
                      setState(() {
                        _activeIndexCategory = 0;
                      });
                    });
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
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        List.generate(state.categories.length + 1, (index) {
                      if (index == 0) {
                        return CategoryItem(
                          onTab: () {
                            setState(() {
                              _activeIndexCategory = index;
                            });
                            _scrollToTop();

                            context.read<HomeCubit>().getCategories();
                          },
                          isActive: _activeIndexCategory == index,
                        );
                      }

                      return CategoryItem(
                        onTab: () {
                          setState(() {
                            _activeIndexCategory = index;
                          });
                          context.read<HomeCubit>().listenProducts(
                              state.categories[index - 1].categoryId);
                          _scrollToTop();
                        },
                        categoryModel: state.categories[index - 1],
                        isActive: _activeIndexCategory == index,
                      );
                    }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              if (state.formsStatus == FormsStatus.subLoading)
                SliverToBoxAdapter(child: CircularProgressIndicator.adaptive()),
              if (state.formsStatus != FormsStatus.subLoading)
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        StorageRepository.setString(key: "user_id", value: "");
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
