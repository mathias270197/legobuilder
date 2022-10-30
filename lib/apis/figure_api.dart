import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/figure.dart';

class FigureApi {
  static String server = 'edge-service-mathias270197.cloud.okteto.net';

  static Future<List<Figure>> fetchFigures() async {
    var url = Uri.https(server, '/numberOfStepReviewsByFigure');  

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((figure) => Figure.fromJson(figure)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
