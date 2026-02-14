import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Request sign up (email OTP) — Supabase will send OTP to email
  Future<void> registerWithEmail(String email) async {
    try {
      await _client.auth.signInWithOtp(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Request sign in (email OTP) — Supabase will send OTP to email
  Future<void> loginWithEmail(String email) async {
    try {
      await _client.auth.signInWithOtp(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Verify OTP code (type: "email") - untuk magic link
  /// Returns current Session if successful, otherwise null.
  Future<Session?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _client.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.email,
      );
      // After verifyOtp, Supabase client should have currentSession set
      return response.session ?? _client.auth.currentSession;
    } catch (e) {
      rethrow;
    }
  }

  /// Verify magic link token directly (used when token is in URL/deep link)
  Future<Session?> verifyMagicLinkToken(String token) async {
    try {
      final response = await _client.auth.verifyOTP(
        token: token,
        type: OtpType.email,
      );
      return response.session ?? _client.auth.currentSession;
    } catch (e) {
      rethrow;
    }
  }

  /// Get current session
  Session? get currentSession => _client.auth.currentSession;

  /// Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Create or update user profile in `users` table using auth `User` object
  /// Expects a `users` table with primary key `id` (text) and `email` column.
  Future<void> upsertUserProfile(
    User user, {
    Map<String, dynamic>? extra,
  }) async {
    try {
      final Map<String, dynamic> row = {
        'id': user.id,
        'email': user.email,
        'updated_at': DateTime.now().toIso8601String(),
      };
      if (extra != null) {
        row.addAll(extra);
      }

      await _client.from('users').upsert(row);
    } catch (e) {
      // don't fail authentication flow if profile upsert fails — rethrow for now
      rethrow;
    }
  }
}
