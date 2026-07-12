import 'package:flutter/material.dart';
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:maruthimedical/features/checkout/order_page.dart';

class ProductPage extends StatefulWidget {
  final String medName, medUrl, category;
  final int? userid;
  final int medid;
  final double price;
  const ProductPage({
    super.key,
    required this.medName,
    required this.userid,
    required this.medid,
    this.price = 0,
    required this.category,
    required this.medUrl,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.medUrl, width: double.infinity, height: 300),
              SizedBox(height: 30),
              Text(
                widget.medName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(widget.category),
              SizedBox(height: 30),
              Text(
                "₹ ${widget.price}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button( 
                    height: 56,
                    width: 175,
                    text: "Buy Now",
                    borderRadius: 10,
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(userid:widget.userid,medid:widget.medid),
                          ),
                        );
                    },
                  ),
                  Button(
                    height: 56,
                    width: 175,
                    text: "Add to Cart",
                    borderRadius: 10,
                    icon: true,
                    sufixicon: Icons.shopping_cart_outlined,
                    color: [Colors.transparent, Colors.transparent],
                    boxshadow: Colors.transparent,
                    bordercolor: Color(0xFF1E5BD8),
                    onpressed: () {
                      if (widget.userid != null) {
                        addToCart(widget.userid, widget.medid, context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
