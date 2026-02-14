import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<OnboardingItem> items = [
    OnboardingItem(
      image: 'assets/img_boarding.png',
      title: 'Rawat Lansia Jadi Lebih Percaya Diri',
      subtitle:
          'Dari panduan medis AI hingga manajemen obat, semua ada dalam satu genggaman untuk dampingi orang tersayang',
    ),
    OnboardingItem(
      image: 'assets/img_boarding.png',
      title: 'Solusi Medis yang Mudah Dipahami',
      subtitle:
          'Tanya Djiwa AI kapan saja dan cek keamanan obat hanya dengan foto. Minimalkan risiko, maksimalkan perawatan.',
    ),
    OnboardingItem(
      image: 'assets/img_boarding.png',
      title: 'Kamu Tidak Berjuang Sendiri',
      subtitle:
          'Kami bantu jaga kesehatan mentalmu agar kamu terhindar dari stres berlebih',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Preload the first and second image at reduced size to avoid large decode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int decodeWidth =
          (MediaQuery.of(context).size.width *
                  MediaQuery.of(context).devicePixelRatio)
              .toInt();
      if (items.isNotEmpty) {
        precacheImage(
          ResizeImage(AssetImage(items[0].image), width: decodeWidth),
          context,
        );
      }
      if (items.length > 1) {
        // small delay to avoid blocking first-frame work
        Future.delayed(const Duration(milliseconds: 200), () {
          precacheImage(
            ResizeImage(AssetImage(items[1].image), width: decodeWidth),
            context,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 70),
              // Image section (doesn't fill entire page)
              Expanded(
                flex: 2,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    // Use ResizeImage so the decoder works on a smaller size and
                    // avoids decoding a huge bitmap on the main thread.
                    final image = ResizeImage(
                      AssetImage(items[index].image),
                      width:
                          (MediaQuery.of(context).size.width *
                                  MediaQuery.of(context).devicePixelRatio)
                              .toInt(),
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image(image: image, fit: BoxFit.contain),
                    );
                  },
                ),
              ),
              // Content section
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        items[_currentPage].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        items[_currentPage].subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Dots indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          items.length,
                          (dotIndex) => Container(
                            width: _currentPage == dotIndex ? 12 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == dotIndex
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Next button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < items.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to next screen
                        Navigator.of(context).pushReplacementNamed('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Spacer(), // dorong ke tengah

                        Text(
                          _currentPage == items.length - 1
                              ? 'Daftar'
                              : 'Selanjutnya',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const Spacer(), // bagi ruang kanan

                        Image.asset(
                          'assets/ic_arrow.png',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Fixed Skip button at top
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text(
                'Lewati',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
