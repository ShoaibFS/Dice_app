import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import '../../../core/constants/app_constants.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              _buildThemeTile(context, ref, settings),
            ],
          ),
          _buildSection(
            context,
            'Feedback',
            [
              SwitchListTile(
                title: const Text('Sound Effects'),
                subtitle: const Text('Play sound when rolling dice'),
                secondary: const Icon(Icons.volume_up),
                value: settings.soundEnabled,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).setSoundEnabled(value);
                },
              ),
              SwitchListTile(
                title: const Text('Haptic Feedback'),
                subtitle: const Text('Vibrate when rolling dice'),
                secondary: const Icon(Icons.vibration),
                value: settings.vibrationEnabled,
                onChanged: (value) {
                  ref.read(settingsProvider.notifier).setVibrationEnabled(value);
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'About',
            [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                subtitle: Text(AppConstants.appVersion),
              ),
              ListTile(
                leading: const Icon(Icons.casino),
                title: const Text('App Name'),
                subtitle: Text(AppConstants.appName),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
  
  Widget _buildThemeTile(BuildContext context, WidgetRef ref, settings) {
    return ListTile(
      leading: Icon(
        settings.themeMode == ThemeMode.dark
            ? Icons.dark_mode
            : Icons.light_mode,
      ),
      title: const Text('Theme'),
      subtitle: Text(
        settings.themeMode == ThemeMode.dark ? 'Dark' : 'Light',
      ),
      trailing: Switch(
        value: settings.themeMode == ThemeMode.dark,
        onChanged: (value) {
          ref.read(settingsProvider.notifier).toggleTheme();
        },
      ),
      onTap: () {
        ref.read(settingsProvider.notifier).toggleTheme();
      },
    );
  }
}
