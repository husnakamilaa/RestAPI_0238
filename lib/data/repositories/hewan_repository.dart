import 'package:rest_api/data/models/hewan_model.dart';
import 'package:rest_api/data/providers/storage_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HewanRepository {
  final String baseUrl = "https://ternak-be-production.up.railway.app/api/v1";
  final StorageProvider storage = StorageProvider();

  
}
