import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Simple auth guard to check session and redirect to login if unauthenticated
Future<bool> ensureAuthenticated(BuildContext context) async {
  final client = Supabase.instance.client;
  final session = client.auth.currentSession;
  if (session == null) {
    // Not authenticated — redirect to login
    Navigator.of(context).pushReplacementNamed('/login');
    return false;
  }
  return true;
}
