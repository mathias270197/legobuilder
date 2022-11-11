import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import '../models/figure.dart';
import '../models/figure_review.dart';

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

  static Future<FigureReview> fetchFigureReview(String figureName) async {
    final LocalStorage storage = LocalStorage('localstorage_app');
    final user = storage.getItem('username');
    var url = Uri.https(server, '/figureReviewByNameAndUser/$figureName/$user');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.contentLength != 0) {
        return FigureReview.fromJson(jsonDecode(response.body));
      } else {
        return FigureReview(
            date: "",
            user: user,
            figureName: figureName,
            stars: 5,
            textReview: "");
      }
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<FigureReview> createFigureReview(
      FigureReview figureReview) async {
    var url = Uri.https(server, '/figureReview');
    figureReview.date =
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(figureReview),
    );
    if (response.statusCode == 200) {
      return FigureReview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create review');
    }
  }

  static Future<FigureReview> updateFigureReview(
      FigureReview figureReview) async {
    var url = Uri.https(server, '/figureReview');

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(figureReview),
    );
    if (response.statusCode == 200) {
      return FigureReview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update review');
    }
  }

  static Future deleteFigureReview(String figureName, String user) async {
    var url = Uri.https(server, '/figureReviewByNameAndUser/$figureName/$user');

    final http.Response response = await http.delete(url);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete review');
    }
  }
}
