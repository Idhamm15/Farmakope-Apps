import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:klasifikasi_tanaman_herbal/models/predict_model.dart';

class ApiService {
  static const String _baseUrl = 'https://c758-182-2-68-68.ngrok.io';

  // NOTE : PREDICT
  Future<PredictModel> predict(String image) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/predict'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"": image}),
      );

      if (response.statusCode == 200) {
        return PredictModel.fromJson(json.decode(response.body));
      } else {
        throw 'Gagal memuat data';
      }
    } catch (e) {
      throw '$e';
    }
  }
}
