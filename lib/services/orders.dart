import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:maruthimedical/services/login_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> getAddress(int? userid, BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.get(
      Uri.parse("$apiUrl/order/getaddress/$userid"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data["data"] == null || (data["data"] as List).isEmpty) {
        return [];
      }
      return List<Map<String, dynamic>>.from(data["data"]);
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      if (!context.mounted) return [];
      bool refreshed=await refreshAccessToken();
      if(refreshed){ 
        if(!context.mounted) return [];
        return getAddress(userid, context);
      }
      else{
        if (!context.mounted) return [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to get address"),
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

Future<bool> postAddress(int? userid,String address,BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.post(
      Uri.parse("$apiUrl/order/postaddress"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode({
        "userid": userid,
        "address": address,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      if (!context.mounted) return false;
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if(!context.mounted) return false;
        return postAddress(userid, address, context);
      }
      else{
        if (!context.mounted) return false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to post address"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        return false;
      }
    } 
    else {
      if (!context.mounted) return false;
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
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.get(
      Uri.parse("$apiUrl/order/getmedicine/$medid/$usrid"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      }, 
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data["data"];
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if(!context.mounted) return {};
        return getMedicine(medid, usrid, context);
      }
      else{
        if (!context.mounted) return {};
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to get all medicines"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        return {};
      }
    }
    else {
      if (!context.mounted) return {};
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



Future<bool> deleteAddress(int? addressid,int? uid,BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    String apiUrl = dotenv.env["API_URL"]!;

    final response = await http.delete(
      Uri.parse("$apiUrl/order/deleteaddress"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: jsonEncode({
        "userid":uid,
        "addressid":addressid
      })
    );
    final data = jsonDecode(response.body);
    if(response.statusCode == 200 && data["detail"] == "Address deleted successfully"){
      return true;
    }
    else if(response.statusCode == 401 && data["detail"] == "Invalid or expired token"){
      if (!context.mounted) return false;
      bool refreshed=await refreshAccessToken();
      if(refreshed){
        if(!context.mounted) return false;
        return deleteAddress(addressid,uid, context);
      }
      else{
        if (!context.mounted) return false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login to delete address"),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        return false;
      }
    } 
    else {
      if (!context.mounted) return false;
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
