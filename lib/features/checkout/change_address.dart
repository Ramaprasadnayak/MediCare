import 'package:flutter/material.dart';

class ChangeAddress extends StatefulWidget {
  final int? id;
  final List<String> myaddress;

  const ChangeAddress({
    super.key,
    required this.id,
    required this.myaddress,
  });

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}
class _ChangeAddressState extends State<ChangeAddress> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Address")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: RadioGroup<int>(
          groupValue: selectedIndex,
          onChanged: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          child: ListView.builder(
            itemCount: widget.myaddress.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Radio<int>(
                    value: index,
                  ),
                  title: Text(widget.myaddress[index]),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}