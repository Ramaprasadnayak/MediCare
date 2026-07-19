import 'package:flutter/material.dart';
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:maruthimedical/widgets/product_page.dart';

class MyMedicineCard extends StatelessWidget {
  final Map<String, dynamic> medicine;
  final int? userid;
  const MyMedicineCard({
    super.key,
    required this.medicine,
    required this.userid,
  });

  @override
  Widget build(BuildContext context) {
    String name = medicine["medicine_name"];
    String medname = name.length > 25 ? "${name.substring(0, 25)}..." : name;
    return SizedBox(
      height: 330,
      width: 200,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(
                    medid: medicine["med_id"],
                    userid: userid,
                    medName: name,
                    price: double.parse(medicine["price"].toString()),
                    category: medicine["category"],
                    medUrl: medicine["image_url"],
                  ),
                ),
              ),
              child: Image.network(
                medicine["image_url"],
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return const SizedBox(
                    height: 140,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 140,
                    child: Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    medname,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(medicine["category"]),
                  Text(medicine["price"].toString()),
                  SizedBox(height: 1),
                  Button(
                    height: 40,
                    width: 150,
                    text: "Add to cart",
                    onpressed: () {
                      if (userid != null) {
                        addToCart(userid, medicine["med_id"], context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                    icon: true,
                    sufixicon: Icons.shopping_cart_outlined,
                  ),
                  SizedBox(height: 9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
