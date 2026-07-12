import 'package:flutter/material.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderTotal extends StatefulWidget {
  const OrderTotal({super.key});

  @override
  State<OrderTotal> createState() => _OrderTotalState();
}

class _OrderTotalState extends State<OrderTotal> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Order Summary",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 25,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sub Total",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
            Text(
              cartProvider.grandTotal.toStringAsFixed(2),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Fee",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
            Text(
              "₹${cartProvider.deliveryFee}",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: Colors.grey, thickness: 1),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Grand Total",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 23),
            ),
            Text(
              cartProvider.amount.toStringAsFixed(2),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 23),
            ),
          ],
        ),
      ],
    );
  }
}
