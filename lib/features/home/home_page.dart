import 'package:flutter/material.dart';
import 'package:maruthimedical/core/widgets/carosel.dart';
import 'package:maruthimedical/services/search_medicine.dart';
// import 'package:maruthimedical/core/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.all(18),
              child:SearchBar(
                  controller: search,
                  hintText: "Search medicines...",
                  leading: const Icon(Icons.search),
                  onSubmitted: (value)async {
                    await searchMedicine(search.text,context);
                  }
                ),
            ),
            SizedBox(height: 20),
            Carosel(),
            SizedBox(height: 20),
            Text("Explore Categories"),
          ],
        ),
    );
  }
}