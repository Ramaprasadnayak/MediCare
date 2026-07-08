import 'package:flutter/material.dart';
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:maruthimedical/widgets/button.dart';

class MyMedicineCard extends StatelessWidget {
  final Map<String, dynamic> medicine;
  final int? userid; 
  const MyMedicineCard({super.key, required this.medicine,required this.userid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      width: 200,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(medicine["image_url"],width: 40,height: 40,),
              Text(
                medicine["medicine_name"],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(medicine["category"]),
              Text(medicine["price"].toString()),
              SizedBox(height: 20),
              Button(
                height: 40,
                width: 150,
                text: "Add to cart",
                onpressed: () {
                  if(userid!=null){
                    addToCart(userid, medicine["med_id"], context);
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }
                },
                icon: true,
                sufixicon: Icons.shopping_cart_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
