import 'package:flutter/material.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
import 'package:maruthimedical/services/cart_action.dart';
import 'package:provider/provider.dart';

class MyCartMedicineCard extends StatefulWidget {
  final Map<String, dynamic> medicine;
  final int? userid;
  final int qty;
  const MyCartMedicineCard({
    super.key,
    required this.medicine,
    required this.userid,
    this.qty = 1,
  });
  @override
  State<MyCartMedicineCard> createState() => _MyCartMedicineCardState();
}

class _MyCartMedicineCardState extends State<MyCartMedicineCard> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 3,top: 10,bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.medicine["medicine_name"],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.medicine["category"]),
                  Text(widget.medicine["price"].toString()),
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("alert"),
                          content: Text("delete this item ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteFromCart(
                                  widget.userid,
                                  widget.medicine["medid"],
                                  context,
                                );
                                setState(() {});
                                context.read<CartProvider>().removeItem(
                                  widget.medicine["medid"],
                                );
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                  ),
                  Card(
                    color: isDark
                        ? const Color(0xFF374151)
                        : const Color(0xFFE2E8F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await alterQuantity(
                              widget.userid,
                              widget.medicine["medid"],
                              0,
                              context,
                            );
                            context.read<CartProvider>().decreaseQuantity(
                              widget.medicine["medid"],
                            );
                          },
                          child: Text(
                            "-",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                          ),
                        ),
                        Text(
                          "${widget.medicine["quantity"]}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () async {
                            await alterQuantity(
                              widget.userid,
                              widget.medicine["medid"],
                              1,
                              context,
                            );
                            context.read<CartProvider>().increaseQuantity(
                              widget.medicine["medid"],
                            );
                          },
                          child: Text(
                            "+",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
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
