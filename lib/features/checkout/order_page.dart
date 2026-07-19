import 'package:flutter/material.dart';
import 'package:maruthimedical/features/checkout/delivery_address.dart';
import 'package:maruthimedical/features/checkout/order_summary.dart';
import 'package:maruthimedical/features/checkout/order_summary2.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:maruthimedical/features/checkout/payment_option.dart';

class OrderPage extends StatefulWidget {
  final int? userid,medid;
  
  const OrderPage({super.key,required this.userid,this.medid});
  @override
  State<OrderPage> createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              DeliveryAddress(
                uid:widget.userid,
              ),  
              SizedBox(height: 20),
              widget.medid!=null?OrderSummary(userId:widget.userid,medid:widget.medid):OrderSummary2(userId: widget.userid),
              SizedBox(height: 30),
              PaymentOption(),
              SizedBox(height: 30),
              Button(
                height: 70, 
                width: double.infinity, 
                text: "Proceed TO Buy, ${cartProvider.amount}", 
                onpressed: (){
                  // comming soon
                }
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
