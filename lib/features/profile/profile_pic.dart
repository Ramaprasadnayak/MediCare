import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:maruthimedical/services/profile_upload.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}
class _ProfilePicState extends State<ProfilePic> {
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.first.path!);
      String? imageUrl = await uploadToCloudinary(file, context);
      if (imageUrl != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload Successful")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File upload cancelled")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListTile(
          onTap: pickFile,
          leading: const Icon(Icons.upload_outlined),
          title: const Text("Upload"),
        ),
      ),
    );
  }
}