import 'package:flutter/material.dart';
import 'package:maruthimedical/features/cart/order_total.dart';
import 'package:maruthimedical/features/checkout/order_page.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:maruthimedical/services/get_detail.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:maruthimedical/widgets/mycart_medicinecard.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? userId;
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Future<void> loaddata() async {
    try {
      userId = await loadTokenId();
      if (userId != null) {
        final data = await cartSearch(userId, context);
        Provider.of<CartProvider>(context, listen: false).setCart(data);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Cart",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: cartProvider.cartData
                  .map<Widget>(
                    (medicines) => MyCartMedicineCard(userid: userId,medicine: medicines),
                  )
                  .toList(),
            ), 
            SizedBox(height: 20),
            OrderTotal(),
            SizedBox(height: 20),
            Button(
              height: 70, 
              width: double.infinity, 
              text: "Proceed TO Buy", 
              onpressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderPage(userid: userId)));
              }
            )
          ],
        ),
      ),
    ); 
  }
}
