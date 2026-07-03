import 'package:flutter/material.dart';
import 'package:maruthimedical/core/widgets/card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final VoidCallback? onpress = null;

    Map<int, List<Object?>> profileOptions = {
      1: [Icons.light_mode_rounded, "Change Theme", true, onpress],
      2: [Icons.phone_android_rounded, "Change Phone Number", false, null],
      3: [Icons.lock_reset_rounded, "Change Password", false, null],
      4: [Icons.support_agent_rounded, "Contact Us", false, null],
      5: [Icons.delete_forever_rounded, "Delete Account", false, null],
      6: [Icons.logout_rounded, "Logout", false, null],
    };
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: profileOptions.entries.map((entry) {
            return MyCard(
              prefixIcon: entry.value[0] as IconData,
              text: entry.value[1] as String,
              addButton: entry.value[2] as bool,
              onPress: entry.value[3] as VoidCallback?,
            );
          }).toList(),
        ),
      ),
    );
  }
}
