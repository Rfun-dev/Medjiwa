import 'package:aceate/core/theme/app_colors.dart';
import 'package:aceate/core/widgets/activiity_item.dart';
import 'package:aceate/core/widgets/circle_icon_btn.dart';
import 'package:aceate/core/widgets/shadow_textbutton.dart';
import 'package:flutter/material.dart';
import '../../core/utils/mood_enum.dart';
import '../../core/widgets/mood_avatar_item.dart';
import '../../core/widgets/moodresponse.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Mood? selectedMood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SizedBox(
        height: 1000,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background Gradient
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              top: selectedMood != null ? -10 : -180,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/bg_ellipse.png', // placeholder
                height: 500,
                fit: BoxFit.cover,
              ),
            ),

            // Main Content
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      _buildHeader(),

                      const SizedBox(height: 24),

                      // Mood Selector
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Mood.values.map((mood) {
                          return MoodAvatarItem(
                            mood: mood,
                            isSelected: selectedMood == mood,
                            onTap: () {
                              setState(() => selectedMood = mood);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      // Content Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            // Mood Response Card
                            if (selectedMood != null) ...[
                              MoodResponseCard(mood: selectedMood!),
                              const SizedBox(height: 16),
                            ],

                            // Ringkasan Perawatan Card
                            _buildRingkasanPerawatanCard(),

                            const SizedBox(height: 16),

                            // Kewalahan Card
                            _buildKewalahanCard(),

                            const SizedBox(height: 16),

                            // Aktivitas Perawatan Card
                            _buildAktivitasPerawatanCard(),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Halo, Galih!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Bagaimana kabarmu hari ini?',
                style: TextStyle(color: AppColors.background, fontSize: 12),
              ),
            ],
          ),
          CircleIconButton(
            imagePath: 'assets/ic_refresh.png',
            onTap: () {
              // Refresh action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanPerawatanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Perawatan Hari Ini',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Terakhir diperbarui 2 jam lalu',
            style: TextStyle(fontSize: 12, color: AppColors.gray),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/ic_clock.png',
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Obat berikutnya 13.00',
                    style: TextStyle(fontSize: 14, color: AppColors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Amlodipine 5 mg',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Divider(thickness: 0.5, height: 1, color: AppColors.gray),
          ),
          const SizedBox(height: 14),
          _buildInfoRow('Sudah diminum', '2 dari 3'),
          const SizedBox(height: 6),
          _buildInfoRow('Ketersediaan obat', 'Cukup'),
          const SizedBox(height: 6),
          _buildInfoRow('Status komitmen obat', 'Aman', isStatusPositive: true),
          const SizedBox(height: 14),
          Center(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              child: ShadowTextButton(
                widht: 350,
                text: 'Lihat detail perawatan',
                backgroundColor: AppColors.background,
                textColor: AppColors.primary,
                borderColor: AppColors.gray,
                borderWidth: 0.5,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool? isStatusPositive}) {
    Color valueColor;

    if (isStatusPositive == null) {
      valueColor = Colors.black; // mode biasa
    } else {
      valueColor = isStatusPositive
          ? AppColors
                .primary // hijau
          : Colors.red; // merah
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.gray),
        ),
        Text(value, style: TextStyle(fontSize: 14, color: valueColor)),
      ],
    );
  }

  Widget _buildKewalahanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3CCF91), Color(0xFF2BAE8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Apakah kamu sedang\nmerasa kewalahan?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Beberapa aktivitas perawatan terlewat\nminggu ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
              const SizedBox(width: 12),
              Image.asset(
                'assets/ic_kewalahan.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ],
          ),
          ShadowTextButton(
            text: 'Cerita sekarang',
            widht: 350,
            backgroundColor: AppColors.primary,
            textColor: AppColors.background,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAktivitasPerawatanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aktivitas Perawatan Hari Ini',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              ActivityItem(value: '6', label: 'Terjadwal'),
              SizedBox(
                height: 55,
                child: VerticalDivider(color: Color(0xFFE2E8F0), thickness: 1),
              ),
              ActivityItem(value: '3', label: 'Belum selesai'),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: ShadowTextButton(
              widht: 350,
              text: 'Lihat semua aktivitas',
              backgroundColor: AppColors.background,
              textColor: AppColors.primary,
              borderColor: AppColors.gray,
              borderWidth: 0.5,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF048973) : Colors.grey[400],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: isActive ? const Color(0xFF048973) : Colors.grey[400],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildNavItemCenter() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF048973),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF048973).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.chat_bubble, color: Colors.white, size: 26),
    );
  }
}
