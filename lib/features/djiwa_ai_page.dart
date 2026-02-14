import 'package:aceate/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DjiwaAiPage extends StatefulWidget {
  const DjiwaAiPage({super.key});

  @override
  State<DjiwaAiPage> createState() => _DjiwaAiPageState();
}

class _DjiwaAiPageState extends State<DjiwaAiPage> {
  final List<String> historyItems = const [
    'Hari ini Ibu terlihat lebih lemah dari biasanya ...',
    'Aku merasa cukup berat merawat ibu sendiri ...',
    'Ibu tampak lebih pucat setelah sarapan dan ...',
  ];

  void _openChat({required String title, String? initialUserMessage}) {
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            DjiwaChatPage(title: title, initialUserMessage: initialUserMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: "AI Djiwa",
              onBack: () {
                final nav = Navigator.of(context);
                if (nav.canPop()) {
                  nav.pop();
                } else {
                  nav.pushReplacementNamed(
                    '/home',
                  ); // ganti dengan route home kamu
                }
              },
            ),

            /// CONTENT (SCROLLABLE)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const _HeroSection(),
                    const SizedBox(height: 18),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FeatureCard(
                          title: 'Tanya soal obat',
                          icon: 'assets/ic_obat.png',
                          onTap: () => _openChat(
                            title: 'Tanya soal obat',
                            initialUserMessage: 'Tanya soal obat',
                          ),
                        ),
                        FeatureCard(
                          title: 'Riwayat perawatan',
                          icon: 'assets/ic_riwayat.png',
                          onTap: () => _openChat(
                            title: 'Riwayat perawatan',
                            initialUserMessage: 'Riwayat perawatan',
                          ),
                        ),
                        FeatureCard(
                          title: 'Cerita hari ini',
                          icon: 'assets/ic_catatan.png',
                          onTap: () => _openChat(
                            title: 'Cerita hari ini',
                            initialUserMessage: 'Cerita hari ini',
                          ),
                        ),
                        FeatureCard(
                          title: 'Catat keluhan',
                          icon: 'assets/ic_catatan.png',
                          onTap: () => _openChat(
                            title: 'Catat keluhan',
                            initialUserMessage: 'Catat keluhan',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    SectionHeader(
                      title: 'Riwayat',
                      actionText: 'Lihat semua',
                      onActionTap: () => _openChat(
                        title: 'Riwayat',
                        initialUserMessage: 'Lihat semua riwayat',
                      ),
                    ),

                    const SizedBox(height: 6),

                    HistoryList(
                      items: historyItems,
                      onTapItem: (text) =>
                          _openChat(title: 'Riwayat', initialUserMessage: text),
                      onMoreTap: (text) {},
                    ), // space for bottom composer
                  ],
                ),
              ),
            ),

            /// BOTTOM INPUT (FIX: tidak pakai Expanded di sini)
            BottomComposer(
              hintText: 'Cerita, tanya, atau catat sesuatu...',
              onMicTap: () {},
              onSendTap: () => _openChat(
                title: 'Chat',
                initialUserMessage: 'Halo Djiwa AI 👋',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// CHAT MODELS
/// =======================
enum ChatRole { user, ai }

class ChatMessage {
  final ChatRole role;
  final String text;
  final DateTime time;

  ChatMessage({required this.role, required this.text, DateTime? time})
    : time = time ?? DateTime.now();
}

/// =======================
/// CHAT PAGE (DENGAN BUBBLE)
/// =======================
class DjiwaChatPage extends StatefulWidget {
  final String title;
  final String? initialUserMessage;

  const DjiwaChatPage({
    super.key,
    required this.title,
    this.initialUserMessage,
  });

  @override
  State<DjiwaChatPage> createState() => _DjiwaChatPageState();
}

class _DjiwaChatPageState extends State<DjiwaChatPage> {
  late final TextEditingController _controller;
  final List<ChatMessage> _messages = [];
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    final seed = widget.initialUserMessage?.trim();
    if (seed != null && seed.isNotEmpty) {
      _messages.add(ChatMessage(role: ChatRole.user, text: seed));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      _scroll.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(role: ChatRole.user, text: text));
      _controller.clear();
    });

    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      'Mulai chat di bawah ya 🙂',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final m = _messages[index];
                      return ChatBubble(message: m);
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: ChatComposer(
                controller: _controller,
                hintText: 'Tulis pesan...',
                onMicTap: () {},
                onSendTap: _send,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================
/// CHAT UI
/// =======================
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}

class ChatComposer extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onMicTap;
  final VoidCallback onSendTap;

  const ChatComposer({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onMicTap,
    required this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSendTap(),
                  ),
                ),
                IconButton(
                  onPressed: onMicTap,
                  icon: Image.asset(
                    'assets/ic_microphone.png',
                    color: AppColors.primary,
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.25),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            onPressed: onSendTap,
            icon: Image.asset(
              'assets/ic_send.png',
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================
/// HOME UI
/// =======================
class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _TopBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 25),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40), // supaya title tetap center
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          child: Center(
            child: Image.asset('assets/ic_ball.png', width: 120, height: 120),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Aku Siap Mendengarkan dan\nMembantu',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        const Text(
          'Mau mulai dari mana?',
          style: TextStyle(color: AppColors.gray),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 16 padding kiri + 16 kanan + 12 spacing antar card
    final width = (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2;

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(icon, width: 24, height: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: onActionTap,
          child: Text(
            actionText,
            style: const TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class HistoryList extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onTapItem;
  final ValueChanged<String> onMoreTap;

  const HistoryList({
    super.key,
    required this.items,
    required this.onTapItem,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final text = items[i];
        return InkWell(
          onTap: () => onTapItem(text),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
              ],
            ),
            child: ListTile(
              title: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => onMoreTap(text),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =======================
/// BOTTOM COMPOSER (FIXED)
/// =======================
class BottomComposer extends StatelessWidget {
  final String hintText;
  final VoidCallback onMicTap;
  final VoidCallback onSendTap;

  const BottomComposer({
    super.key,
    required this.hintText,
    required this.onMicTap,
    required this.onSendTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                onPressed: onMicTap,
                icon: Image.asset(
                  'assets/ic_microphone.png',
                  color: AppColors.primary,
                  width: 30,
                  height: 30,
                ),
              ),
              IconButton(
                onPressed: onSendTap,
                icon: Image.asset('assets/ic_send.png', width: 56, height: 56),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
