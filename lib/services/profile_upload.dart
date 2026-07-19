import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> uploadToCloudinary(File file,BuildContext context) async {
  String apiUrl=dotenv.env["CLAUDINARY_URL"]!;
   print("\n\n\n\n\nUpload button clicked\n\n\n\n\n");

  String uploadPreset=dotenv.env["CLAUDINARY_UPLOAD_PRESET"]!;
  final url = Uri.parse(apiUrl);
  var request = http.MultipartRequest("POST", url);
  request.fields["upload_preset"] = uploadPreset;
  request.files.add(
    await http.MultipartFile.fromPath("file",file.path),
  );
  var response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final data = jsonDecode(responseData);
    return data["secure_url"];
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
    return "";
  }
}