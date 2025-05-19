import 'package:flutter/material.dart';
import 'package:stockly/ui/settings/viewmodel/settings_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.viewmodel});

  final SettingsViewmodel viewmodel;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Tema',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Switch(
                  value: widget.viewmodel.isDark,
                  onChanged: (value) {
                    setState(() {
                      widget.viewmodel.toggleTheme();
                    });
                  },
                  thumbIcon: WidgetStatePropertyAll(
                    Icon(
                      widget.viewmodel.isDark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                  ),
                  activeColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
