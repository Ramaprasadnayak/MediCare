import 'package:flutter/material.dart';
import 'package:maruthimedical/widgets/button.dart';

class MyMedicineCard extends StatelessWidget {
  final Map<String, dynamic> medicine;
  const MyMedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: 200,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine["medicine_name"],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(medicine["category"]),
              Text(medicine["price"].toString()),
              SizedBox(height: 20),
              Button(
                height: 40,
                width: 150,
                text: "Add to cart",
                onpressed: () {},
                icon: true,
                sufixicon: Icons.shopping_cart_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
