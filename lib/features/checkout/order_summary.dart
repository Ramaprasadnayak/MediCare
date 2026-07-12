import 'package:flutter/material.dart';
import 'package:maruthimedical/features/cart/order_total.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/services/orders.dart';
import 'package:maruthimedical/widgets/mycart_medicinecard.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  final int? userId, medid;
  const OrderSummary({
    super.key,
    required this.userId,
    required this.medid,
  });
  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}
class _OrderSummaryState extends State<OrderSummary> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadMedicine();
  }
  Future<void> loadMedicine() async {
    final medicine = await getMedicine(
      widget.medid,
      widget.userId,
      context,
    );
    if (!mounted) return;
    context.read<CartProvider>().setCart([medicine]);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (cartProvider.cartData.isEmpty) {
          return const Center(
            child: Text("No medicine found"),
          );
        }
        return Column(
          children: [
            Column(
              children: cartProvider.cartData.map((medicine) {
                return MyCartMedicineCard(
                  medicine: medicine,
                  userid: widget.userId,
                );
              }).toList(),
            ),
            OrderTotal()
          ],
        );
      },
    );
  }
}