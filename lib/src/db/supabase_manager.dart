// ignore_for_file: non_constant_identifier_names, avoid_print
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class SupabaseManager {

  final clien = Supabase.instance.client;

  Future<void> signUpUser({required email, required password}) async {
    print("email:$email password:$password");
    // final result = await client.auth.signUp(email!, password!);
  }
}

