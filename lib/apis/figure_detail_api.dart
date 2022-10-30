import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import '../models/figure_detail.dart';


class FigureDetailApi {
  static String server = 'edge-service-mathias270197.cloud.okteto.net';

  static Future<List<FigureDetail>> fetchFigureDetails(String figureName) async {
    final LocalStorage storage = new LocalStorage('localstorage_app');
    final name = storage.getItem('username');
    print(name);
    
    var url = Uri.https(server, '/reviewAndStepsOfFigure/$figureName/$name');


    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((figureDetail) => FigureDetail.fromJson(figureDetail)).toList();
    } else {
      throw Exception('Failed to load FigureDetail');
    }
  }
}