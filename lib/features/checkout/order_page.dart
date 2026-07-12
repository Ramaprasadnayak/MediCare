import 'package:flutter/material.dart';
import 'package:maruthimedical/features/checkout/delivery_address.dart';
import 'package:maruthimedical/features/checkout/order_summary.dart';
import 'package:maruthimedical/features/checkout/payment_option.dart';
import 'package:maruthimedical/services/orders.dart';

class OrderPage extends StatefulWidget {
  final int? userid;
  const OrderPage({super.key,required this.userid});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<String> addresses=[];
  
  @override
  void initState() {
    super.initState();
    loadAddress();
  }
  void loadAddress() async {
    List<String> address = await getAddress(widget.userid, context);;
    setState(() {
      addresses=address;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              DeliveryAddress(
                uid:widget.userid,
                address:addresses
              ),  
              OrderSummary(), 
              PaymentOption()
            ],
          ),
        ),
      ),
    );
  }
}
