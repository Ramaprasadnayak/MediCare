import 'package:flutter/material.dart';
import 'package:maruthimedical/core/constants/category_list.dart';
import 'package:maruthimedical/widgets/category_card.dart';

class ExploreCategories extends StatefulWidget {
  final int limit;
  const ExploreCategories({super.key,this.limit=10});
  @override
  State<ExploreCategories> createState() => _ExploreCaregoriesState();
}
class _ExploreCaregoriesState extends State<ExploreCategories> {
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: categoryData.take(widget.limit)
              .map<Widget>(
                (category) => MyCategoryCard(
                  name: category.name,
                  imageUrl: category.imageUrl
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
