import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _service = AuthService();

  /// Trigger register flow (email) and navigate to OTP page
  Future<void> register({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onError,
    void Function(bool)? onLoading,
  }) async {
    try {
      onLoading?.call(true);
      await _service.registerWithEmail(email);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      onLoading?.call(false);
    }
  }

  /// Trigger login flow (email OTP) and navigate to OTP page
  Future<void> login({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
    required Function(String) onError,
    void Function(bool)? onLoading,
  }) async {
    try {
      onLoading?.call(true);
      await _service.loginWithEmail(email);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      onLoading?.call(false);
    }
  }

  /// Verify OTP and navigate to home when successful
  Future<void> verifyOtp({
    required BuildContext context,
    required String email,
    required String otp,
    required VoidCallback onSuccess,
    required Function(String) onError,
    void Function(bool)? onLoading,
  }) async {
    try {
      onLoading?.call(true);
      final session = await _service.verifyOtp(email: email, otp: otp);
      if (session != null) {
        final user = session.user;
        if (user != null) {
          // ensure user exists in users table
          await _service.upsertUserProfile(user);
        }
        onSuccess();
      } else {
        onError('Kode OTP tidak valid atau sesi tidak dikembalikan');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      onLoading?.call(false);
    }
  }

  /// Verify magic link token directly (from deep link / URL)
  Future<void> verifyMagicLinkToken({
    required BuildContext context,
    required String token,
    required VoidCallback onSuccess,
    required Function(String) onError,
    void Function(bool)? onLoading,
  }) async {
    try {
      onLoading?.call(true);
      final session = await _service.verifyMagicLinkToken(token);
      if (session != null) {
        final user = session.user;
        if (user != null) {
          // ensure user exists in users table
          await _service.upsertUserProfile(user);
        }
        onSuccess();
      } else {
        onError('Token tidak valid atau sesi tidak dikembalikan');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      onLoading?.call(false);
    }
  }

  /// Sign out user
  Future<void> signOut() => _service.signOut();
}
