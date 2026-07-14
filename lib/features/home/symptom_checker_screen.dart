import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../ai/ai_usage_limiter.dart';
import '../ai/flowing_text.dart';
import '../ai/openai_service.dart';
import '../ai/models/chat_message.dart';
import '../app_state/app_state_provider.dart';
import '../app_state/profile_context.dart';
import '../cycle/cycle_provider.dart';
import '../log/widgets/symptoms_selector.dart';
import '../subscription/subscription_provider.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final Set<String> selected = {};
  final TextEditingController notesController = TextEditingController();

  bool loading = false;
  String? error;
  String? result;
  int remainingFree = AiUsageLimiter.freeMessagesPerDay;
  bool isPremium = false;

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final premium = context.read<SubscriptionProvider>().isPremium;
      final remaining = premium ? 0 : await AiUsageLimiter.remainingFreeMessages();
      if (mounted) {
        setState(() {
          isPremium = premium;
          remainingFree = remaining;
        });
      }
    });
  }

  Future<void> _analyze() async {
    final t = AppLocalizations.of(context);

    if (selected.isEmpty) {
      setState(() => error = t.noSymptomsSelected);
      return;
    }

    if (!isPremium && remainingFree <= 0) return;

    final cycle = context.read<CycleProvider>();

    setState(() {
      loading = true;
      error = null;
      result = null;
    });

    final languageName = switch (Localizations.localeOf(context).languageCode) {
      'fr' => 'French',
      'ar' => 'Arabic',
      _ => 'English',
    };

    final symptomLabels = selected.map((key) => SymptomsSelector.label(t, key)).join(', ');
    final notes = isPremium ? notesController.text.trim() : '';
    final contraceptionNote = contraceptionContext(context.read<AppStateProvider>().contraceptionMethod);

    final systemContext =
        'You are Dawrati AI, a warm and knowledgeable menstrual health assistant '
        'inside the Dawrati app. The user is on cycle day ${cycle.cycleDay}, in the '
        '${cycle.phase} phase, and reports these symptoms today: $symptomLabels. '
        '${notes.isNotEmpty ? 'They also shared these extra details: $notes. ' : ''}'
        '${contraceptionNote != null ? '$contraceptionNote ' : ''}'
        'In 3-5 short sentences, explain how these symptoms might relate to their '
        'current cycle phase and give practical, gentle self-care suggestions. '
        'You are not a doctor and this is not a diagnosis — if the symptoms sound '
        'severe or unusual, gently suggest seeing a healthcare professional. '
        'Always respond in $languageName.';

    try {
      final reply = await OpenAiService.sendMessage(
        history: [ChatMessage(role: ChatRole.user, text: 'Analyze my symptoms.')],
        systemContext: systemContext,
      );

      if (!isPremium) {
        await AiUsageLimiter.recordMessageSent();
        final remaining = await AiUsageLimiter.remainingFreeMessages();
        if (mounted) setState(() => remainingFree = remaining);
      }

      if (!mounted) return;
      setState(() {
        loading = false;
        result = '';
      });
      await for (final partial in flowText(reply)) {
        if (!mounted) return;
        setState(() => result = partial);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loading = false;
        error = e is OpenAiException ? _errorLabel(t, e.message) : t.aiChatGenericError;
      });
    }
  }

  String _errorLabel(AppLocalizations t, String code) {
    if (code == 'missing_api_key') return t.aiChatMissingKey;
    if (code == 'network_error') return t.aiChatNetworkError;
    return t.aiChatGenericError;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final limitReached = !isPremium && remainingFree <= 0;

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
                Expanded(
                  child: Text(
                    t.symptomCheckerScreenTitle,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ),
                if (!isPremium)
                  Text(
                    t.aiFreeMessagesLeft(remainingFree),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(t.selectSymptomsPrompt, style: const TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: SymptomsSelector.symptoms.map((item) {
                final isSelected = selected.contains(item.$1);
                return FilterChip(
                  selected: isSelected,
                  label: Text(SymptomsSelector.label(t, item.$1)),
                  avatar: Icon(
                    item.$2,
                    size: 18,
                    color: isSelected ? Colors.white : const Color(0xFFE91E63),
                  ),
                  selectedColor: const Color(0xFFE91E63),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                  side: BorderSide(
                    color: isSelected ? const Color(0xFFE91E63) : Colors.grey.shade200,
                  ),
                  onSelected: (_) => setState(() {
                    isSelected ? selected.remove(item.$1) : selected.add(item.$1);
                  }),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            Stack(
              children: [
                TextField(
                  controller: notesController,
                  enabled: isPremium,
                  maxLines: 3,
                  minLines: 3,
                  decoration: InputDecoration(
                    labelText: t.symptomNotesLabel,
                    hintText: isPremium ? t.symptomNotesHint : null,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                if (!isPremium)
                  Positioned.fill(
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => Navigator.pushNamed(context, '/premium'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(Icons.lock, size: 18, color: Color(0xFFE91E63)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  t.symptomNotesPremiumLock,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFE91E63),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 22),

            if (limitReached)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1B2E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.aiFreeLimitReachedTitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      t.aiFreeLimitReachedDesc,
                      style: const TextStyle(color: Colors.white70, height: 1.4, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/premium'),
                        child: Text(t.tryPremium),
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: loading ? null : _analyze,
                  child: loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(t.analyzeSymptoms, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),

            if (error != null) ...[
              const SizedBox(height: 12),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],

            if (result != null) ...[
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 24, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Color(0xFFE91E63)),
                        const SizedBox(width: 10),
                        Text(t.symptomAnalysisTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(result!, style: const TextStyle(fontSize: 15, height: 1.5)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
            Text(
              t.notDiagnosisTool,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
