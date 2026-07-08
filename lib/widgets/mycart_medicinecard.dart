import 'package:flutter/material.dart';
import 'package:maruthimedical/services/cart_action.dart';

class MyCartMedicineCard extends StatefulWidget {
  final Map<String, dynamic> medicine;
  final int? userid;
  const MyCartMedicineCard({
    super.key,
    required this.medicine,
    required this.userid,
  });
  @override
  State<MyCartMedicineCard> createState() => _MyCartMedicineCardState();
}

class _MyCartMedicineCardState extends State<MyCartMedicineCard> {
  late int quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.medicine["quantity"];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(0),
      child: SizedBox(
        height: 150,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
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
                                  Navigator.of(context).pop();
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
                            onPressed: () {
                              alterQuantity(
                                widget.userid,
                                widget.medicine["medid"],
                                0,
                                context,
                              ).then((_) {
                                setState(() {
                                  quantity--;
                                });
                              });
                            },
                            child: Text(
                              "-",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                            ),
                          ),
                          Text(
                            "$quantity",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              alterQuantity(
                                widget.userid,
                                widget.medicine["medid"],
                                1,
                                context,
                              ).then((_) {
                                setState(() {
                                  quantity++;
                                });
                              });
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
      ),
    );
  }
}
