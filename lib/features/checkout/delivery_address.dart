import 'package:flutter/material.dart';
import 'package:maruthimedical/features/checkout/change_address.dart';

class DeliveryAddress extends StatelessWidget {
  final int? uid;
  final List<String> address;

  const DeliveryAddress({
    super.key,
    required this.uid,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Address",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 25),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeAddress(id:uid,myaddress:address)));
                  },
                  child: Text(
                    "Change",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              address[0],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 25
              )
            )
          ],
        ),
      ),
    );
  }
}