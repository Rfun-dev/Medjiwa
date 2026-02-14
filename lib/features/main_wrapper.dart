import 'package:aceate/core/theme/app_colors.dart';
import 'package:aceate/core/widgets/nav_item.dart';
import 'package:aceate/features/care_page.dart';
import 'package:aceate/features/djiwa_ai_page.dart';
import 'package:aceate/features/home_page.dart';
import 'package:aceate/features/jurnal_page.dart';
import 'package:aceate/features/profile_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    JurnalPage(),
    CarePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: _CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _CustomBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // 🔹 Background navbar
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(
                  iconOn: 'assets/ic_home_on.svg',
                  iconOff: 'assets/ic_home_off.svg',
                  label: 'Beranda',
                  active: currentIndex == 0,
                  onTap: () => onTap(0),
                ),

                NavItem(
                  iconOn: 'assets/ic_jurnal_on.svg',
                  iconOff: 'assets/ic_jurnal_off.svg',
                  label: 'Jurnal',
                  active: currentIndex == 1,
                  onTap: () => onTap(1),
                ),

                const SizedBox(width: 56),

                NavItem(
                  iconOn: 'assets/ic_love_on.svg',
                  iconOff: 'assets/ic_love_off.svg',
                  label: 'Perawatan',
                  active: currentIndex == 2,
                  onTap: () => onTap(3),
                ),

                NavItem(
                  iconOn: 'assets/ic_profile_on.svg',
                  iconOff: 'assets/ic_profile_off.svg',
                  label: 'Profil',
                  active: currentIndex == 3,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),

          Positioned(
            top: -16,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/djiwa_ai');
              },
              child: Container(
                height: 100,
                width: 90,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/ic_ai.png', height: 80, width: 80),
                    Text(
                      'Djiwa AI',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: currentIndex == 2
                            ? AppColors.primary
                            : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
