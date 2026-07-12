import 'package:flutter/material.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  int? selectedIndex = 0;

  final List<Map<String, String>> options = [
    {"name": "Razor Pay", "img": "assets/payment/razorpay.png"},
    {"name": "Cash on Delivery", "img": "assets/payment/cashondelivery.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Options",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        RadioGroup<int>(
          groupValue: selectedIndex,
          onChanged: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          options[index]["img"]!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            options[index]["name"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Radio<int>(value: index),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
