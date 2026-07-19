import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/services/login_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:maruthimedical/providers/cart_provider.dart';
 
Future<List<Map<String, dynamic>>> cartSearch(int? userid,BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.get(
      Uri.parse("$apiUrl/cart/userid/$userid"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      }
    );
    final data = jsonDecode(response.body); 
    if (response.statusCode == 200 && data["message"] == "Retrieved cart info") {
      return List<Map<String, dynamic>>.from(data["data"]);
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if (!context.mounted) return [];
        return cartSearch(userid, context);
      }
      else{
        if (!context.mounted) return [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to get cart features"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        return [];
      }
    }
    else {
      if (!context.mounted) return [];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  } catch (e) {
    if (!context.mounted) return [];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
    return [];
  }
}

Future<void> addToCart(int? userid,int medid,BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.post(
      Uri.parse("$apiUrl/cart/addtocart"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode({
        "usrid": userid,
        "medid": medid,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Added to cart") {
      if (!context.mounted) return;
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
      if (!context.mounted) return;
      final cart = await cartSearch(userid, context);
      if (!context.mounted) return;
      context.read<CartProvider>().setCart(cart);
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if (!context.mounted) return;
        addToCart(userid,medid,context);
      }
      else{
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to access cart features"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    } 
    else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
  }
}

Future<void> alterQuantity(int? userid,int medid,int action,BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.post(
      Uri.parse("$apiUrl/cart/addtocart/quantity"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body:jsonEncode({
        "usrid": userid,
        "medid": medid,
        "action":action
      })
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Quantity updated") {
      // success
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if (!context.mounted) return;
        alterQuantity(userid, medid, action, context);
      }
      else{
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to alter qty"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    } 
    else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Something went wrong :$e"),duration: Duration(seconds: 2),backgroundColor: Colors.red)
    );
  }
}

Future<void> deleteFromCart(int? userid,int medid,BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.delete(
      Uri.parse("$apiUrl/cart/deletefromcart"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode({
        "usrid": userid,
        "medid": medid,
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Deleted from cart") {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item deleted"),
        backgroundColor: Colors.green,
      ),
    );
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if(!context.mounted) return;
        deleteFromCart(userid, medid, context);
      }
      else{
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to delete from cart"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    } 
    else {
      if (!context.mounted) return;
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
