import 'package:flutter/material.dart';
import 'package:maruthimedical/widgets/carosel.dart';
import 'package:maruthimedical/services/search_medicine.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SearchBar(
              controller: search,
              hintText: "Search medicines...",
              leading: const Icon(Icons.search),
              onSubmitted: (value) async {
                await searchMedicine(search.text, context);
              },
            ),
            SizedBox(height: 20),
            Carosel(),
            SizedBox(height: 20),
            Text(
              "Explore Categories",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
