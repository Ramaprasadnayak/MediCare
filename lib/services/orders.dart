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
      if (data["data"] == null) {
        return ["No address saved yet."];
      }

      return data["data"]["address"] ?? "No address saved yet.";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["detail"] ?? "Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
      return [""];
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Something went wrong: $e"),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
    return [""];
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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Success"),
          content: const Text("Address updated successfully."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );

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