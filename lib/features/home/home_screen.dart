import 'package:flutter/material.dart';
import 'package:maruthimedical/features/home/profile_page.dart';
import 'package:maruthimedical/theme/theme_providers.dart';
import 'package:provider/provider.dart';
import 'package:maruthimedical/features/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void setTheme(int idx) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("theme", idx);
  }

  @override
  void initState() {
    super.initState();
  }

  void navigateBottonBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ElevatedButton(onPressed: (){}, child: const Text("Fetch")),
      Center(child: Text("categories")),
      Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<ThemeProvider>().setTheme(ThemeMode.light);
          },
          child: const Text("Light"),
        ),
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<ThemeProvider>().setTheme(ThemeMode.dark);
          },
          child: const Text("Dark"),
        ),
      ),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Ramprasad"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: navigateBottonBar,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
