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
  int? selectedIndex;
  List<Map<String, dynamic>> addresses=[];
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    List<Map<String, dynamic>> address = await getAddress(widget.id, context);
    if (!mounted) return;
    setState(() {
      addresses = address;
      if (addresses.isNotEmpty) {
        selectedIndex = 0;
      }
    });
  }

  Future<void> storeAddress() async {
    if (selectedIndex == null || addresses.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("address", addresses[selectedIndex!]["address"]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Address")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: addresses.isEmpty
                ? const Center(child: Text("No addresses found"))
                : RadioGroup<int>(
                    groupValue: selectedIndex,
                    onChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    child: ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                child: ListTile(
                                  leading: Radio<int>(value: index),
                                  title: Text(addresses[index]["address"]),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                bool success = await deleteAddress(
                                  addresses[index]["addressid"],
                                  widget.id,
                                  context,
                                );
                                if (success) {
                                  await loadAddress();
                                }
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ),
          Button(
            height: 56,
            width: 380,
            text: "+ Add New Address",
            color: const [Colors.transparent, Colors.transparent],
            boxshadow: Colors.transparent,
            bordercolor: const Color.fromARGB(255, 67, 71, 79),
            onpressed: () async {
              await showDialog(
                context: context,
                builder: (_) {
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
                          if(controller.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("address cant be empty"))
                            );
                          }
                          else{
                            bool success = await postAddress(
                              widget.id,
                              controller.text.trim(),
                              context,
                            );
                            if (success) {
                              controller.clear();
                              Navigator.pop(context);
                              await loadAddress();
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("New address added"),
                                ),
                              );
                            }}
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Button(
                  height: 56,
                  width: 380,
                  text: "Deliver To This Address",
                  onpressed: () async {
                    if (selectedIndex == null || addresses.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Alert"),
                          content: const Text("Please select an address"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
                   await storeAddress();
                    if (!mounted) return;
                    Navigator.pop(context, true);
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
