import 'package:flutter/material.dart';
import 'package:maruthimedical/services/get_detail.dart';
import 'package:maruthimedical/widgets/medicine_card.dart';
import 'package:maruthimedical/services/search_medicine.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> medicineData;
  final String querry;
  const SearchPage({super.key, required this.medicineData,required this.querry});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  int? userId;
  @override
  void initState() { 
    super.initState();
    getuserId();
  }
  Future<void> getuserId() async {
    final id=await loadTokenId();
    setState(() {
      userId=id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.querry),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18),
              child: SearchBar(
                controller: search,
                hintText: "Search medicines...",
                leading: const Icon(Icons.search),
                onSubmitted: (value) async {
                  await searchMedicine(search.text, context);
                },
              ),
            ),
            SizedBox(height: 50),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: widget.medicineData.map<Widget>(
                    (medicines) => MyMedicineCard(userid:userId,medicine: medicines),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
