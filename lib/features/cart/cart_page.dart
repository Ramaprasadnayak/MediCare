import 'package:flutter/material.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:maruthimedical/services/get_detail.dart';
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
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
                          (cartProvider.grandTotal + cartProvider.deliveryFee).toStringAsFixed(2),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 23),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
