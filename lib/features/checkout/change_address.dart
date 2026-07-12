import 'package:flutter/material.dart';
import 'package:maruthimedical/services/orders.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAddress extends StatefulWidget {
  final int? id;
  const ChangeAddress({super.key, required this.id});

  @override
  State<ChangeAddress> createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  int? selectedIndex = 0;
  List<String> addresses=[];
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadAddress();
  }
  void loadAddress() async {
    List<String> address = await getAddress(widget.id, context);
    setState(() {
      addresses=address;
    });
  }
  @override
  Widget build(BuildContext context) {
    Future<void> storeAddress() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("address", addresses[selectedIndex!]);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Change Address")),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: RadioGroup<int>(
              groupValue: selectedIndex,
              onChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Radio<int>(value: index),
                      title: Text(addresses[index]),
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
          Button(
            height: 56,
            width: 380,
            text: "+ Add New Address",
            color: [Colors.transparent, Colors.transparent],
            boxshadow: Colors.transparent,
            bordercolor: Color.fromARGB(255, 67, 71, 79),
            onpressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add Address"),
                    content: TextField(
                      controller: controller,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Enter your address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool success = await postAddress(
                            widget.id,
                            controller.text.trim(),
                            context,
                          );
                          if (success) {
                            controller.clear();
                            loadAddress();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("new address added"))
                            );
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                  top: 20,
                ),
                child: Button(
                  height: 56,
                  width: 380,
                  text: "Deliver To This Address",
                  onpressed: () async {
                    if (selectedIndex != null) {
                      await storeAddress();
                      Navigator.pop(context, true);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("alert"),
                          content: Text("Select a address"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
