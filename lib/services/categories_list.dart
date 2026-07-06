import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List> categoriesList(String category,BuildContext context) async{
  try {
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.get(
      Uri.parse("$apiUrl/medicines/category/?query=$category"),
      headers: {"Content-Type": "application/json"}
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Medicines fetched successfully") {
      return data["category"];
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