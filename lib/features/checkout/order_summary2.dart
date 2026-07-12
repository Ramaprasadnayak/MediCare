import 'package:flutter/material.dart';
import 'package:maruthimedical/features/cart/order_total.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/widgets/mycart_medicinecard.dart';
import 'package:provider/provider.dart';

class OrderSummary2 extends StatefulWidget {
  final int? userId;
  const OrderSummary2({super.key, required this.userId});

  @override
  State<OrderSummary2> createState() => _OrderSummary2State();
}

class _OrderSummary2State extends State<OrderSummary2> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Column(
      children: [
        Column(
          children: cartProvider.cartData
              .map<Widget>(
                (medicines) =>
                    MyCartMedicineCard(userid: widget.userId, medicine: medicines),
              )
              .toList(),
        ),
        OrderTotal(),
      ],
    );
  }
}
