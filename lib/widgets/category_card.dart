import 'package:flutter/material.dart';
import 'package:maruthimedical/services/categories_list.dart';

class MyCategoryCard extends StatelessWidget {
  final String imageUrl, name;
  const MyCategoryCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>categoriesList(name,context),
      child: SizedBox(
        height: 123,
        width: 123,
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 5),
              Image.asset(
                imageUrl,
                width: 80,
                height:80,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              Text(name,style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}
