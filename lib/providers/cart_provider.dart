import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cartData = [];
  double grandTotal = 0;

  double get deliveryFee {
    if (grandTotal == 0) return 0;
    if (grandTotal > 500) return 0;
    return 40;
  }

  void setCart(List<Map<String, dynamic>> data) {
    cartData = data;
    calculateTotal();
    notifyListeners();
  }

  void calculateTotal() {
    grandTotal = cartData.fold(
      0.0,
      (sum, item) => sum + (item["total"] as num).toDouble(),
    );
  }

  void increaseQuantity(int medid) {
    final item = cartData.firstWhere((e) => e["medid"] == medid);

    item["quantity"]++;
    item["total"] = item["quantity"] * item["price"];

    calculateTotal();
    notifyListeners();
  }

  void decreaseQuantity(int medid) {
    final item = cartData.firstWhere((e) => e["medid"] == medid);

    if (item["quantity"] > 1) {
      item["quantity"]--;
      item["total"] = item["quantity"] * item["price"];
      calculateTotal();
      notifyListeners();
    }
  }

  void removeItem(int medid) {
    cartData.removeWhere((e) => e["medid"] == medid);

    calculateTotal();
    notifyListeners();
  }
}
