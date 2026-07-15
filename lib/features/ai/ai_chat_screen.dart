import 'package:flutter/material.dart';

import '../../core/theme/app_color_scheme.dart';
import '../../l10n/app_localizations.dart';
import 'ai_usage_limiter.dart';
import 'flowing_text.dart';
import 'models/chat_message.dart';
import 'openai_service.dart';

class AiChatScreen extends StatefulWidget {
  final String systemContext;
  final bool isPremium;
  final String? title;
  final String? starterMessage;
  final bool premiumOnly;

  const AiChatScreen({
    super.key,
    required this.systemContext,
    required this.isPremium,
    this.title,
    this.starterMessage,
    this.premiumOnly = false,
  });

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  bool sending = false;
  String? error;
  int remainingFree = AiUsageLimiter.freeMessagesPerDay;

  @override
  void initState() {
    super.initState();
    if (widget.starterMessage != null) {
      messages.add(ChatMessage(role: ChatRole.model, text: widget.starterMessage!));
    }
    if (!widget.isPremium && !widget.premiumOnly) {
      AiUsageLimiter.remainingFreeMessages().then((value) {
        if (mounted) setState(() => remainingFree = value);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  bool get _limitReached =>
      widget.premiumOnly ? !widget.isPremium : (!widget.isPremium && remainingFree <= 0);

  Future<void> _send() async {
    final text = controller.text.trim();
    if (text.isEmpty || sending) return;

    if (_limitReached) return;

    final t = AppLocalizations.of(context);

    setState(() {
      messages.add(ChatMessage(role: ChatRole.user, text: text));
      controller.clear();
      sending = true;
      error = null;
    });
    _scrollToBottom();

    try {
      final reply = await OpenAiService.sendMessage(
        history: messages,
        systemContext: widget.systemContext,
      );

      if (!widget.isPremium && !widget.premiumOnly) {
        await AiUsageLimiter.recordMessageSent();
        final remaining = await AiUsageLimiter.remainingFreeMessages();
        if (mounted) setState(() => remainingFree = remaining);
      }

      if (!mounted) return;
      setState(() {
        sending = false;
        messages.add(const ChatMessage(role: ChatRole.model, text: ''));
      });
      final modelIndex = messages.length - 1;
      await for (final partial in flowText(reply)) {
        if (!mounted) return;
        setState(() => messages[modelIndex] = ChatMessage(role: ChatRole.model, text: partial));
        _scrollToBottom();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        sending = false;
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
    final limitReached = _limitReached;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 22, 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 4),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFFFEAF3),
                    backgroundImage: AssetImage('assets/images/articles/coach.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title ?? t.dawratiAiLabel,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  if (!widget.isPremium && !widget.premiumOnly)
                    Text(
                      t.aiFreeMessagesLeft(remainingFree),
                      style: TextStyle(fontSize: 11, color: colors.textSecondary),
                    ),
                ],
              ),
            ),
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          t.aiChatEmptyState,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colors.textSecondary, fontSize: 16),
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) => _bubble(context, messages[index]),
                    ),
            ),
            if (sending)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFE91E63)),
                ),
              ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                child: Text(error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
              ),
            if (limitReached)
              Container(
                margin: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1B2E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.premiumOnly ? t.premiumOnlyFeatureTitle : t.aiFreeLimitReachedTitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.premiumOnly ? t.premiumOnlyFeatureDesc : t.aiFreeLimitReachedDesc,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onSubmitted: (_) => _send(),
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          hintText: t.aiChatInputHint,
                          filled: true,
                          fillColor: colors.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFFE91E63),
                      child: IconButton(
                        onPressed: sending ? null : _send,
                        icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bubble(BuildContext context, ChatMessage message) {
    final isUser = message.role == ChatRole.user;
    final colors = context.colors;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFFE91E63) : colors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : colors.textPrimary,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
