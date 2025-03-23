import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/mbti_type.dart';

class MbtiService {
  Future<List<MbtiType>> loadMbtiTypes() async {
    try {
      final String response = await rootBundle.loadString('assets/mbti16.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => MbtiType.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
