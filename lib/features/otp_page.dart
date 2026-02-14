import 'dart:async';

import 'package:aceate/core/controllers/auth_controller.dart';
import 'package:aceate/core/theme/app_colors.dart';
import 'package:aceate/core/widgets/otp_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _secondsRemaining = 45;
  Timer? _timer;
  bool _isLoading = false;
  late String _email;
  bool _initialized = false;

  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Get email from route arguments
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
      _initialized = true;
      startTimer();
    }
  }

  void startTimer() {
    _secondsRemaining = 45;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _verifyOtp() async {
    final otp = controllers.map((c) => c.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan 6 digit OTP')),
      );
      return;
    }

    // TODO: Commented temporarily to work on home feature
    // final controller = AuthController();
    // await controller.verifyOtp(
    //   context: context,
    //   email: _email,
    //   otp: otp,
    //   onSuccess: () {
    Navigator.of(context).pushReplacementNamed('/home');
    //   },
    //   onError: (msg) {
    //     ScaffoldMessenger.of(
    //       context,
    //     ).showSnackBar(SnackBar(content: Text('Verifikasi gagal: $msg')));
    //   },
    //   onLoading: (loading) {
    //     setState(() => _isLoading = loading);
    //   },
    // );

    // Temporary: Navigate to home for testing
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              Image.asset('assets/ic_light_horizontal_mode.png', width: 120),

              const SizedBox(height: 32),

              const Text(
                'Satu Langkah Lagi',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Masukkan 6 digit kode OTP yang telah dikirim ke emailmu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return OtpInput(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    nextFocus: index < 5 ? focusNodes[index + 1] : null,
                    onCompleted: index == 5 ? _verifyOtp : null,
                  );
                }),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verifikasi'),
                ),
              ),

              const SizedBox(height: 24),

              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black54),
                  children: [
                    const TextSpan(text: 'Belum menerima kode? '),
                    if (_secondsRemaining == 0)
                      TextSpan(
                        text: 'Kirim ulang',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            startTimer();
                            // TODO: Commented temporarily - call resendOtp with email when ready
                            // await controller.resendOtp(email: _email);
                          },
                      )
                    else
                      TextSpan(text: 'Kirim ulang ($_secondsRemaining)'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
