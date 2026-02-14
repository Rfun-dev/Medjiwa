import 'package:aceate/core/widgets/shadow_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:aceate/core/theme/app_colors.dart';

class JurnalPage extends StatelessWidget {
  const JurnalPage({super.key});

  void _openCompose(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const JournalComposePage()));
  }

  @override
  Widget build(BuildContext context) {
    final history = <JournalEntry>[
      const JournalEntry(
        dateLabel: "Hari ini • 08.30",
        preview:
            "Sejak pagi rasanya sudah capek. Ibu belum mau makan pagi, sempat khawatir. Tapi untungnya ...",
        fullText:
            "Sejak pagi rasanya sudah capek. Ibu belum mau makan pagi, sempat khawatir.\n\n"
            "Tapi untungnya siang hari ibu mau makan sedikit. Aku jadi agak lega. "
            "Aku juga mencoba mengatur ulang jadwal obat agar lebih teratur. "
            "Besok aku ingin lebih pelan-pelan dan kasih ruang buat istirahat.",
      ),
      const JournalEntry(
        dateLabel: "6 Feb • 20.45",
        preview:
            "Ibu terlihat lebih ceria hari ini. Bahkan sempat cerita tentang masa mudanya. Rasanya bahagia ...",
        fullText:
            "Hari ini ibu lebih ceria. Kami ngobrol tentang masa mudanya. "
            "Aku merasa hangat dan bersyukur karena momen kecil seperti ini terasa berarti.\n\n"
            "Aku juga belajar untuk tidak terlalu keras pada diri sendiri.",
      ),
      const JournalEntry(
        dateLabel: "5 Feb • 15.24",
        preview:
            "Hari biasa saja. Rutinitas seperti biasa. Tapi merasa lebih tenang karena obat sudah lebih teratur ...",
        fullText:
            "Rutinitas berjalan normal. Walau melelahkan, aku merasa lebih tenang "
            "karena jadwal obat sudah mulai rapi dan aku tidak terlalu panik seperti kemarin.\n\n"
            "Aku mau tetap konsisten, sedikit demi sedikit.",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// =======================
            /// Header Cards
            /// =======================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _ThanksCard(),
                    const SizedBox(height: 12),
                    _WriteSpaceCard(onTap: () => _openCompose(context)),
                    const SizedBox(height: 16),
                    const Text(
                      "Riwayat",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            /// =======================
            /// Riwayat (Expandable)
            /// =======================
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: i == history.length - 1 ? 0 : 12,
                    ),
                    child: JournalHistoryExpandableItem(entry: history[i]),
                  );
                }, childCount: history.length),
              ),
            ),

            /// Space bawah supaya aman dari BottomNav/FAB kamu
            const SliverToBoxAdapter(child: SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }
}

/// =======================================================
/// MODEL
/// =======================================================
class JournalEntry {
  final String dateLabel;
  final String preview;
  final String fullText;

  const JournalEntry({
    required this.dateLabel,
    required this.preview,
    required this.fullText,
  });
}

class _ThanksCard extends StatelessWidget {
  const _ThanksCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF037C5C), AppColors.primary, Color(0xFFF2A3D5)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terima kasih",
                  style: TextStyle(
                    color: AppColors.background,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Sudah meluangkan waktu\nuntuk dirimu sendiri. Setiap\nlangkah kecil itu penting",
                  style: TextStyle(
                    color: AppColors.background,
                    height: 1.25,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          /// Logo/Mascot placeholder (ganti pakai asset kamu kalau sudah ada)
          Container(
            width: 64,
            height: 64,
            child: Center(
              child: Image.asset(
                "assets/ic_card_sad.png",
                width: 64,
                height: 64,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WriteSpaceCard extends StatelessWidget {
  final VoidCallback onTap;
  const _WriteSpaceCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Ruang untuk menuliskan apa\nyang kamu rasakan hari ini",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ShadowTextButton(
              text: "Tulis jurnal hari ini",
              onPressed: onTap,
              backgroundColor: AppColors.primary,
              textColor: AppColors.background,
              widht: 250,
            ),
          ),
        ],
      ),
    );
  }
}

class JournalHistoryExpandableItem extends StatefulWidget {
  final JournalEntry entry;

  const JournalHistoryExpandableItem({super.key, required this.entry});

  @override
  State<JournalHistoryExpandableItem> createState() =>
      _JournalHistoryExpandableItemState();
}

class _JournalHistoryExpandableItemState
    extends State<JournalHistoryExpandableItem> {
  bool _expanded = false;

  void _toggle() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.entry;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// date + arrow
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        e.dateLabel,
                        style: TextStyle(fontSize: 14, color: AppColors.gray),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.gray.withOpacity(0.85),
                        size: 22,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// preview (2 lines when collapsed)
                Text(
                  e.preview,
                  maxLines: _expanded ? 8 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.25,
                    color: AppColors.black.withOpacity(0.9),
                  ),
                ),

                /// full detail
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFFE9EEF2),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          e.fullText,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.35,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: _expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 220),
                  sizeCurve: Curves.easeOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JournalComposePage extends StatefulWidget {
  const JournalComposePage({super.key});

  @override
  State<JournalComposePage> createState() => _JournalComposePageState();
}

class _JournalComposePageState extends State<JournalComposePage> {
  final _controller = TextEditingController();
  bool get _canSave => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_canSave) return;

    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _SavedDialog(),
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Buat Jurnal",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + bottomInset),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.primary, Color(0xFF1D6F54)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Text(
                "Tidak ada yang benar atau salah di sini.\n"
                "Yang penting adalah kamu sudah\n"
                "meluangkan waktu untuk dirimu sendiri.",
                style: TextStyle(
                  color: AppColors.background,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Tuliskan perasaanmu",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Bisa kamu baca kembali kapan saja setelah menyimpannya",
              style: TextStyle(color: AppColors.gray, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Container(
              height: 360,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  hintText: "Tulis apa yang kamu rasakan saat ini ...",
                  hintStyle: TextStyle(
                    color: Color(0xFFB0B7C3),
                    fontWeight: FontWeight.w600,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _canSave ? _save : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: const Color(0xFFE5E7EB),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  "Simpan jurnal",
                  style: TextStyle(
                    color: _canSave ? Colors.white : const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedDialog extends StatelessWidget {
  const _SavedDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                'assets/ic_checked.png',
                width: 128,
                height: 128,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Jurnal telah tersimpan",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1FBF6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "✨  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Apa kata Djiwa AI?",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Dari tulisanmu, hari ini terasa cukup\n"
                    "melelahkan. Semoga kamu bisa menemukan\n"
                    "sedikit waktu untuk beristirahat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
                child: const Text(
                  "Selesai",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
