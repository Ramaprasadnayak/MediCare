import 'package:flutter/material.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Address",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 25),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Rahul Sharma, 123 Main st, Mumbai, 574106.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
