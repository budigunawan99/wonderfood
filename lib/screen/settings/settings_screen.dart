import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/provider/settings/notification_provider.dart';
import 'package:wonderfood/provider/settings/notification_shared_preferences_provider.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/style/colors/wonderfood_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    final notificationSharedPreferencesProvider =
        context.read<NotificationSharedPreferencesProvider>();
    final notificationProvider = context.read<NotificationProvider>();

    Future.microtask(() async {
      notificationSharedPreferencesProvider.getNotificationStatus();
      final status = notificationSharedPreferencesProvider.status;
      if (status != null) {
        notificationProvider.setEnabled(status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(isFirstPage: false, title: "Pengaturan"),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - (2 * kToolbarHeight),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            "Pengingat harian",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Switch(
                            value:
                                context.watch<NotificationProvider>().isEnabled,
                            activeColor: Theme.of(context).colorScheme.primary,
                            onChanged: (bool value) async {
                              final notificationSharedPreferencesProvider =
                                  context
                                      .read<
                                        NotificationSharedPreferencesProvider
                                      >();
                              final notificationProvider =
                                  context.read<NotificationProvider>();
                              notificationProvider.setEnabled(
                                !notificationProvider.isEnabled,
                              );
                              try {
                                await notificationSharedPreferencesProvider
                                    .saveNotificationStatus(
                                      notificationProvider.isEnabled,
                                    );
                              } catch (e) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        notificationSharedPreferencesProvider
                                            .message,
                                      ),
                                      backgroundColor:
                                          WonderfoodColors.red.color,
                                    ),
                                  );
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 2, thickness: 0.5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
