import 'package:aceate/core/controllers/auth_controller.dart';
import 'package:aceate/core/theme/app_colors.dart';
import 'package:aceate/core/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;
  bool _obscurePassword = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              Image.asset(
                'assets/ic_light_horizontal_mode.png',
                width: 120,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              const Text(
                'Halo, Selamat Bergabung!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'Belum punya akun? Daftar dulu yuk untuk akses semua fitur',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 32),

              TextFieldCustom(
                type: "Nama",
                hint: "Masukkan nama lengkap",
                controller: _nameController,
              ),

              const SizedBox(height: 16),

              /// EMAIL
              TextFieldCustom(
                type: "Email",
                hint: "Masukkan email",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              /// PASSWORD
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Image.asset(
                      _obscurePassword
                          ? 'assets/ic_eye_close.png'
                          : 'assets/ic_eye_open.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(value: true, onChanged: (_) {}),
                  const Expanded(
                    child: Text(
                      'Dengan membuat akun, kamu menyetujui Syarat & Ketentuan serta Kebijakan Privasi kami',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),

              Spacer(),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    final name = _nameController.text.trim();

                    // TODO: Commented temporarily - Supabase register will be implemented later
                    // final controller = AuthController();
                    // setState(() => _isLoading = true);
                    // await controller.register(
                    //   context: context,
                    //   email: email,
                    //   onSuccess: () {
                    //     Navigator.pushReplacementNamed(
                    //       context,
                    //       '/otp',
                    //       arguments: email,
                    //     );
                    //   },
                    //   onError: (msg) {
                    //     ScaffoldMessenger.of(
                    //       context,
                    //     ).showSnackBar(SnackBar(content: Text(msg)));
                    //   },
                    //   onLoading: (loading) {
                    //     setState(() => _isLoading = loading);
                    //   },
                    // );

                    // Temporary: Direct navigation to OTP page for testing
                    Navigator.pushReplacementNamed(
                      context,
                      '/otp',
                      arguments: email,
                    );
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Buat akun'),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun Medjiwa?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Masuk sekarang',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
