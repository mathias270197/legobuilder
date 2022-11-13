import 'package:flutter/material.dart';
import '../models/figure.dart';
import '../apis/figure_api.dart';
import 'figure_review.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewsPageState();
}


class _ReviewsPageState extends State {
  List<Figure> figureList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _getReviews();
  }

  void _getReviews() {
    FigureApi.fetchFigures().then((result) {
      setState(() {
        figureList = result;
        count = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _reviewListItems(),
      ),
    );
  }

  ListView _reviewListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
                "${figureList[position].name} with ${figureList[position].numberOfSteps} steps to build"),
            onTap: () {
              _navigateToReview(figureList[position].name);
            },
          ),
        );
      },
    );
  }

  void _navigateToReview(String figureName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FigureReviewPage(figureName: figureName)),
    );
    _getReviews();
  }
}
