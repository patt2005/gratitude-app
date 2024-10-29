import 'package:daily_gratitude_app/models/quote.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService instance = ApiService();
  final Dio _dio = Dio();

  Future<Quote> getQuote() async {
    const String apiKey = "QP62Yb1qyUlTqMt172Z/bg==iH57LfkyGHsWJvVZ";
    const String apiUrl =
        "https://api.api-ninjas.com/v1/quotes?category=happiness";

    try {
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {'X-Api-Key': apiKey},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        return Quote(
          text: data[0]["quote"],
          author: data[0]["author"],
        );
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
