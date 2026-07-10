import 'package:flutter/material.dart';
import 'package:maruthimedical/services/search_medicine.dart';
import 'package:maruthimedical/widgets/medicine_card.dart';

class PopularMedicine extends StatefulWidget {
  final int limit;
  final int? userId;
  const PopularMedicine({super.key,required this.userId,this.limit=10});
  @override
  State<PopularMedicine> createState() => _PopularMedicineState();
}
class _PopularMedicineState extends State<PopularMedicine> {
  List<Map<String, dynamic>> medicineData=[];
  @override
  void initState() {
    super.initState();
    loadMedicine();
  }
  void loadMedicine() async{
    List<Map<String, dynamic>> medicineDataset=await searchPopularMedicine(context);
    setState(() {
      medicineData=medicineDataset;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 0,
          runSpacing: 0,
          children: medicineData.take(widget.limit)
              .map<Widget>(
                (medicines) => MyMedicineCard(userid:widget.userId,medicine:medicines)
              )
              .toList(),
        ),
      ],
    );
  }
} 