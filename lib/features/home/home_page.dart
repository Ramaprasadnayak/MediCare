import 'package:flutter/material.dart';
import 'package:maruthimedical/features/home/caregories.dart';
import 'package:maruthimedical/widgets/carosel.dart';
import 'package:maruthimedical/services/search_medicine.dart';

class HomePage extends StatefulWidget {
  final void Function(int) navigate;
  const HomePage({super.key,required this.navigate});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explore Categories",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: ()=>widget.navigate(1),
                  child: Text(
                    "View all",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ExploreCategories(limit: 6),
            SizedBox(height: 20),
            Text(
              "Popular Medicines",
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
