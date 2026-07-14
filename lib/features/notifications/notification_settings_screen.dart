import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/notification_service.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../l10n/app_localizations.dart';
import '../app_state/app_state_provider.dart';
import '../cycle/cycle_provider.dart';
import 'notification_settings_provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  Future<void> _ensurePermission(BuildContext context, AppLocalizations t) async {
    final granted = await NotificationService.instance.requestPermission();
    if (!granted && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.notificationPermissionDeniedMsg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final settings = context.watch<NotificationSettingsProvider>();
    final cycle = context.watch<CycleProvider>();
    final usesPill = context.watch<AppStateProvider>().contraceptionMethod == 'pill';

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 40),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Text(
                  t.notificationsSettingsTitle,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                t.notificationsSettingsSubtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),

            _toggleRow(
              context: context,
              icon: Icons.favorite,
              title: t.periodReminderTitle,
              desc: t.periodReminderDesc,
              value: settings.periodReminder,
              onChanged: (value) async {
                if (value) await _ensurePermission(context, t);
                await settings.setPeriodReminder(
                  value,
                  title: t.periodReminderNotifTitle,
                  body: t.periodReminderNotifBody,
                  predictedPeriodStart: cycle.nextPeriodStartDate,
                );
              },
            ),

            _toggleRow(
              context: context,
              icon: Icons.egg_alt_outlined,
              title: t.ovulationReminderTitle,
              desc: t.ovulationReminderDesc,
              value: settings.ovulationReminder,
              onChanged: (value) async {
                if (value) await _ensurePermission(context, t);
                await settings.setOvulationReminder(
                  value,
                  title: t.ovulationReminderNotifTitle,
                  body: t.ovulationReminderNotifBody,
                  predictedOvulationDate: cycle.nextOvulationDate,
                );
              },
            ),

            if (usesPill)
              _toggleRow(
                context: context,
                icon: Icons.medication_outlined,
                title: t.notifPillReminder,
                desc: t.notifPillReminderDesc,
                value: settings.pillReminder,
                time: settings.pillTime,
                onChanged: (value) async {
                  if (value) await _ensurePermission(context, t);
                  await settings.setPillReminder(
                    value,
                    title: t.pillReminderNotifTitle,
                    body: t.pillReminderNotifBody,
                  );
                },
                onTimeChanged: (time) => settings.setPillTime(
                  time,
                  title: t.pillReminderNotifTitle,
                  body: t.pillReminderNotifBody,
                ),
              ),

            _toggleRow(
              context: context,
              icon: Icons.water_drop,
              title: t.waterReminderTitle,
              desc: t.waterReminderDesc,
              value: settings.waterReminder,
              time: settings.waterTime,
              onChanged: (value) async {
                if (value) await _ensurePermission(context, t);
                await settings.setWaterReminder(
                  value,
                  title: t.waterReminderNotifTitle,
                  body: t.waterReminderNotifBody,
                );
              },
              onTimeChanged: (time) => settings.setWaterTime(
                time,
                title: t.waterReminderNotifTitle,
                body: t.waterReminderNotifBody,
              ),
            ),

            _toggleRow(
              context: context,
              icon: Icons.bedtime,
              title: t.sleepReminderTitle,
              desc: t.sleepReminderDesc,
              value: settings.sleepReminder,
              time: settings.sleepTime,
              onChanged: (value) async {
                if (value) await _ensurePermission(context, t);
                await settings.setSleepReminder(
                  value,
                  title: t.sleepReminderNotifTitle,
                  body: t.sleepReminderNotifBody,
                );
              },
              onTimeChanged: (time) => settings.setSleepTime(
                time,
                title: t.sleepReminderNotifTitle,
                body: t.sleepReminderNotifBody,
              ),
            ),

            _toggleRow(
              context: context,
              icon: Icons.edit_note,
              title: t.dailyLogReminderTitle,
              desc: t.dailyLogReminderDesc,
              value: settings.dailyLogReminder,
              time: settings.dailyLogTime,
              onChanged: (value) async {
                if (value) await _ensurePermission(context, t);
                await settings.setDailyLogReminder(
                  value,
                  title: t.dailyLogReminderNotifTitle,
                  body: t.dailyLogReminderNotifBody,
                );
              },
              onTimeChanged: (time) => settings.setDailyLogTime(
                time,
                title: t.dailyLogReminderNotifTitle,
                body: t.dailyLogReminderNotifBody,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String desc,
    required bool value,
    required ValueChanged<bool> onChanged,
    TimeOfDay? time,
    ValueChanged<TimeOfDay>? onTimeChanged,
  }) {
    final t = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFFFEAF3),
                child: Icon(icon, color: const Color(0xFFE91E63)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              Switch(
                value: value,
                activeThumbColor: const Color(0xFFE91E63),
                onChanged: onChanged,
              ),
            ],
          ),
          if (value && time != null && onTimeChanged != null) ...[
            const Divider(height: 24),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: time);
                if (picked != null) onTimeChanged(picked);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, size: 18, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(t.reminderTimeLabel, style: const TextStyle(color: Colors.grey)),
                    const Spacer(),
                    Text(
                      time.format(context),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
