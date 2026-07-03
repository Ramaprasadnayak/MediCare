import 'package:http/http.dart' as http;
import 'dart:convert';
Future<void> fetchData() async {
  final response =
      await http.get(Uri.parse("http://192.168.1.5:8000"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    print("\n${data["message"]}");
  } else {
    print("\n\n\n\nFailed\n\n\n\n");
  }
}