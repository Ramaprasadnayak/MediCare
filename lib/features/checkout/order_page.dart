import 'package:flutter/material.dart';
import 'package:maruthimedical/features/checkout/delivery_address.dart';
import 'package:maruthimedical/features/checkout/order_summary.dart';
import 'package:maruthimedical/features/checkout/payment_option.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              DeliveryAddress(), 
              OrderSummary(), 
              PaymentOption()
            ],
          ),
        ),
      ),
    );
  }
}
