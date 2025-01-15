import 'package:fire_auth/data/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.onTab,
    this.categoryModel,
    this.title = "All",
    required this.isActive,
  });

  final VoidCallback onTab;
  final CategoryModel? categoryModel;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: isActive ? 1 : 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (categoryModel != null)
              SizedBox(
                width: 50,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(categoryModel!.imageUrl),
                    ),
                  ),
                ),
              ),
            SizedBox(width: 10),
            Text(
              categoryModel?.title ?? title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
