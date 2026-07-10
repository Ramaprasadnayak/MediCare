import 'package:flutter/material.dart';
import 'package:maruthimedical/features/home/caregories.dart';
import 'package:maruthimedical/services/get_detail.dart';
import 'package:maruthimedical/widgets/carosel.dart';
import 'package:maruthimedical/services/search_medicine.dart';
import 'package:maruthimedical/widgets/popular_medicine.dart';

class HomePage extends StatefulWidget {
  final void Function(int) navigate;
  const HomePage({super.key,required this.navigate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  String username = "";
  int? userId;
  @override
  void initState() {
    super.initState();
    getUserDetail();
  }

  Future<void> getUserDetail() async {
    final name = await loadTokenSub();
    final id=await loadTokenId();
    if (name != null) {
      setState(() {
        username = name.length > 15 ? "${name.substring(0, 15)}..." : name;
        userId=id;
      });
    }
  }
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
            SizedBox(height: 20),
            // popular medicine widget 
            PopularMedicine(userId: userId)
          ],
        ),
      ),
    );
  }
}
