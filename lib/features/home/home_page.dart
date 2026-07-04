import 'package:flutter/material.dart';
import 'package:maruthimedical/core/widgets/carosel.dart';
import 'package:maruthimedical/core/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            MyTextField(
              hintText: "Search medicines", 
              height: 60, width: 380, 
              prefixicon:Icons.search, 
              controller: search, 
              eyebutton:false, 
              hideText: false
            ),
            SizedBox(height: 20),
            Carosel(),
            SizedBox(height: 20),
            Text("Explore Categories"),
          ],
        ),
    );
  }
}