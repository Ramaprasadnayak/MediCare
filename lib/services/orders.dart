import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getAddress(int? userid, BuildContext context) async {
  try {
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.get(
      Uri.parse("$apiUrl/order/getaddress/$userid"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data["data"] == null || (data["data"] as List).isEmpty) {
        return ["No address saved yet."];
      }

      return (data["data"] as List)
          .map<String>((item) => item["address"] as String)
          .toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["detail"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Something went wrong: $e"),
        backgroundColor: Colors.red,
      ),
    );
    return [];
  }
}

Future<bool> postAddress(
  int? userid,
  String address,
  BuildContext context,
) async {
  try {
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.post(
      Uri.parse("$apiUrl/order/postaddress"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "userid": userid,
        "address": address,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["detail"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Something went wrong: $e"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
    return false;
  }
}

Future<Map<String, dynamic>> getMedicine(int? medid,int? usrid, BuildContext context) async {
  try {
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.get(
      Uri.parse("$apiUrl/order/getmedicine/$medid/$usrid"),
      headers: {
        "Content-Type": "application/json",
      }, 
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data["data"];
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["detail"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return {};
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Something went wrong: $e"),
        backgroundColor: Colors.red,
      ),
    );
    return {};
  }
}
