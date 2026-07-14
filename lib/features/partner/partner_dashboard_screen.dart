import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/services/cloud_sync_service.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/label_translations.dart';
import '../../screens/auth/login_screen.dart';
import '../calendar/widgets/calendar_grid.dart';
import '../calendar/widgets/calendar_legend_v2.dart';
import '../calendar/widgets/week_header.dart';
import 'partner_mode_provider.dart';

class PartnerDashboardScreen extends StatelessWidget {
  const PartnerDashboardScreen({super.key});

  String _partnerTip(AppLocalizations t, String phase) {
    switch (phase) {
      case 'Menstruation':
        return t.partnerTipMenstruation;
      case 'Follicular':
      case 'Follicular Phase':
        return t.partnerTipFollicular;
      case 'Ovulation':
        return t.partnerTipOvulation;
      case 'Luteal':
      case 'Luteal Phase':
        return t.partnerTipLuteal;
      default:
        return '';
    }
  }

  Future<void> _disconnect(BuildContext context) async {
    await context.read<PartnerModeProvider>().disconnect();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final ownerUid = context.watch<PartnerModeProvider>().ownerUid;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      t.partnerDashboardTitle,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _disconnect(context),
                    icon: const Icon(Icons.logout, color: Colors.grey),
                    tooltip: t.partnerDisconnect,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                t.partnerDashboardSubtitle,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              if (ownerUid == null)
                Center(child: Text(t.partnerCodeInvalid))
              else
                Expanded(
                  child: StreamBuilder<Map<String, dynamic>?>(
                    stream: CloudSyncService.instance.partnerViewStream(ownerUid),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.data;
                      if (data == null) {
                        return Center(child: Text(t.partnerNoDataYet));
                      }

                      final phase = data['phase'] as String? ?? '';
                      final isPremium = data['isPremium'] as bool? ?? false;
                      final cycleDay = data['cycleDay'] as int?;
                      final mood = data['mood'] as String?;
                      final water = (data['water'] as num?)?.toDouble();
                      final sleep = (data['sleep'] as num?)?.toDouble();
                      final nextPeriod = data['nextPeriodDate'] as String?;
                      final nextOvulation = data['nextOvulationDate'] as String?;
                      final periodStartDate = DateTime.tryParse(data['periodStartDate'] as String? ?? '');
                      final averageCycleLength = data['averageCycleLength'] as int?;
                      final periodLength = data['periodLength'] as int?;

                      return ListView(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(26),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFEAF3), Color(0xFFEDE7FF)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.partnerCurrentPhase,
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  translatePhase(t, phase),
                                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  _partnerTip(t, phase),
                                  style: const TextStyle(fontSize: 15, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          if (!isPremium)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1F1B2E),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.partnerPremiumLockTitle,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    t.partnerPremiumLockDesc,
                                    style: const TextStyle(color: Colors.white70, height: 1.4, fontSize: 13),
                                  ),
                                ],
                              ),
                            )
                          else ...[
                            _detailRow(t.partnerCycleDay, cycleDay != null ? '$cycleDay' : '-'),
                            _detailRow(t.partnerMood, mood != null ? translateMoodString(t, mood) : '-'),
                            _detailRow(t.partnerWater, water != null ? '${water.toStringAsFixed(1)} L' : '-'),
                            _detailRow(t.partnerSleep, sleep != null ? '${sleep.toStringAsFixed(1)} h' : '-'),
                            _detailRow(
                              t.partnerNextPeriod,
                              nextPeriod != null ? _formatDate(nextPeriod) : '-',
                            ),
                            _detailRow(
                              t.partnerNextOvulation,
                              nextOvulation != null ? _formatDate(nextOvulation) : '-',
                            ),
                            if (periodStartDate != null && averageCycleLength != null && periodLength != null) ...[
                              const SizedBox(height: 8),
                              _monthCalendar(
                                context,
                                t,
                                periodStartDate: periodStartDate,
                                cycleLength: averageCycleLength,
                                periodLength: periodLength,
                              ),
                            ],
                          ],
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _monthCalendar(
    BuildContext context,
    AppLocalizations t, {
    required DateTime periodStartDate,
    required int cycleLength,
    required int periodLength,
  }) {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, 1);

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
          Text(
            t.partnerCalendarTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat.yMMMM(Localizations.localeOf(context).toString()).format(currentMonth),
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 16),
          const WeekHeader(),
          const SizedBox(height: 8),
          CalendarGrid(
            currentMonth: currentMonth,
            periodStartDate: periodStartDate,
            selectedDate: now,
            cycleLength: cycleLength,
            periodLength: periodLength,
            onSelectDate: (_) {},
          ),
          const SizedBox(height: 12),
          const CalendarLegendV2(),
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    final date = DateTime.tryParse(iso);
    if (date == null) return iso;
    return '${date.year}/${date.month}/${date.day}';
  }

  Widget _detailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
