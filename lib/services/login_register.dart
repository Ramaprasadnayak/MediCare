import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maruthimedical/features/home/home_screen.dart';
import 'package:flutter/material.dart';


Future<void> register(BuildContext context,TextEditingController usrname,TextEditingController phno,TextEditingController password) async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.1.5:8000/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usrname.text.trim(),
        "phone": phno.text.trim(),
        "password": password.text.trim(),
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["message"] == "Registration Successful") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "Registration Failed"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red,duration: Duration(seconds: 2)),
    );
  }
}

Future<void> login(BuildContext context,TextEditingController usrname,TextEditingController password) async{
  try{
    final response=await http.post(
      Uri.parse("http://192.168.1.5:8000/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usrname.text.trim(),
        "password": password.text.trim()
      })
    );
    final data=jsonDecode(response.body);
    if(response.statusCode==200 && data["message"]=="Login Successful"){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Successful"),backgroundColor: Colors.green,duration: Duration(seconds: 2))
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data["message"] ?? "incorrect username or password"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }catch (e){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e"),backgroundColor: Colors.red,duration: Duration(seconds: 2),)
    );
  }
}