import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'dart:developer' as developer;

class AuthRepository {
  final String baseUrl = "https://ternak-be-production.up.railway.app/api/v1";
  final _storage = const FlutterSecureStorage();

  
}