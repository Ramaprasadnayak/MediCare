import 'package:flutter/material.dart';
import 'package:maruthimedical/features/checkout/change_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryAddress extends StatefulWidget {
  final int? uid;
  const DeliveryAddress({super.key, required this.uid});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}
class _DeliveryAddressState extends State<DeliveryAddress> {
  late Future<String> _selectedAddress;
  
  @override
  void initState() {
    super.initState();
    _selectedAddress = getSelectedAddress();
  }

  Future<String> getSelectedAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("address") ?? "Login to add address";
  }

  Future<void> refreshAddress() async {
    setState(() {
      _selectedAddress = getSelectedAddress();
    });
  }

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
                  onPressed: () async {
                    final changed = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeAddress(
                          id: widget.uid
                        ),
                      ),
                    );

                    if (changed == true) {
                      refreshAddress();
                    }
                  },
                  child: const Text("Change"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<String>(
              future: _selectedAddress,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  snapshot.data!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 20),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}