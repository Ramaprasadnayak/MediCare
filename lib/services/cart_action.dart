import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

 
Future<List<Map<String, dynamic>>> cartSearch(int? userid,BuildContext context) async{
  try {
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.get(
      Uri.parse("$apiUrl/cart/userid/$userid"),
      headers: {"Content-Type": "application/json"}
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Retrieved cart info") {
      return List<Map<String, dynamic>>.from(data["data"]);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
    return [];
  }
}

Future<void> addToCart(int? userid,int medid,BuildContext context) async{
  try {
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.post(
      Uri.parse("$apiUrl/cart/addtocart"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usrid": userid,
        "medid": medid,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Added to cart") {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("alert"),
          content: Text("Added to cart"),
          actions: [
            TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
  }
}

Future<void> alterQuantity(int? userid,int medid,int action,BuildContext context) async{
  try {
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.post(
      Uri.parse("$apiUrl/cart/addtocart/quantity"),
      headers: {"Content-Type": "application/json"},
      body:jsonEncode({
        "usrid": userid,
        "medid": medid,
        "action":action
      })
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Quantity updated") {
      // success
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
  }
}

Future<void> deleteFromCart(int? userid,int medid,BuildContext context) async{
  try {
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.delete(
      Uri.parse("$apiUrl/cart/deletefromcart"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usrid": userid,
        "medid": medid,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Deleted from cart") {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item deleted"),
        backgroundColor: Colors.green,
      ),
  );
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
  }
}
