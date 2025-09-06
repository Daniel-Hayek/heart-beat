import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  static final String _projectUrl = dotenv.env['SB_PROJECT']!;
  static final String _storagePath = dotenv.env['SB_PATH']!;

  static String publicUrl(String songPath) {
    return _projectUrl + _storagePath + songPath;
  }
}
