import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/features/search/search_page.dart';
import 'package:maruthimedical/services/login_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> categoriesList(String reqCategory,BuildContext context) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl=dotenv.env["API_URL"]!;
    final response=await http.get(
      Uri.parse("$apiUrl/medicines/category/$reqCategory"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      }
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Medicines fetched successfully") {
      if (!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(medicineData: List<Map<String, dynamic>>.from(data["data"]),querry: reqCategory)));
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if (!context.mounted) return;
        categoriesList(reqCategory, context);
      }
      else{
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to view all medicines"),
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