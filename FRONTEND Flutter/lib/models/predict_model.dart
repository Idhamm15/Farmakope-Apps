class PredictModel {
  PredictModel({
    required this.nama,
    required this.error,
    required this.message,
    required this.probability,
    required this.status,
  });

  final String nama;
  final String error;
  final String message;
  final String probability;
  final String status;

  factory PredictModel.fromJson(Map<String, dynamic> json) => PredictModel(
        nama: json["nama"],
        error: json["error"],
        message: json["message"],
        probability: json["probability"],
        status: json["status"],
      );
}
