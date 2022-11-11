import 'package:flutter/material.dart';

import '../apis/figure_api.dart';
import '../models/figure_review.dart';

import 'package:getwidget/getwidget.dart';

const List<String> choices = <String>[
  'Save review & Back',
  'Delete this review',
  'Back to List'
];

class FigureReviewPage extends StatefulWidget {
  final String figureName;
  const FigureReviewPage({Key? key, required this.figureName})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FigureReviewPageState();
}

class _FigureReviewPageState extends State<FigureReviewPage> {
  FigureReview? figureReview;

  TextEditingController figureNameController = TextEditingController();
  TextEditingController textReviewController = TextEditingController();
  TextEditingController starsController = TextEditingController();

  void _menuSelected(String index) async {
    switch (index) {
      case "0":
        _saveReview();
        break;
      case "1":
        _deleteReview();
        break;
      case "2":
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void _saveReview() {
    figureReview!.figureName = figureNameController.text;
    figureReview!.textReview = textReviewController.text;
    figureReview!.stars = int.parse(starsController.text);

    if (figureReview!.date == '') {
      FigureApi.createFigureReview(figureReview!).then((result) {
        Navigator.pop(context, true);
      });
    } else {
      FigureApi.updateFigureReview(figureReview!).then((result) {
        Navigator.pop(context, true);
      });
    }
  }

  void _deleteReview() {
    FigureApi.deleteFigureReview(figureReview!.figureName, figureReview!.user)
        .then((result) {
      Navigator.pop(context, true);
    });
  }

  @override
  void initState() {
    super.initState();
    _getFigureReview(widget.figureName);
  }

  void _getFigureReview(String figureName) {
    FigureApi.fetchFigureReview(figureName).then((result) {
      setState(() {
        figureReview = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Figure detail"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _menuSelected,
            itemBuilder: (BuildContext context) {
              return choices.asMap().entries.map((entry) {
                return PopupMenuItem<String>(
                  value: entry.key.toString(),
                  child: Text(entry.value),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _figureReview(),
      ),
    );
  }

  _figureReview() {
    if (figureReview == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

      figureNameController.text = figureReview!.figureName;
      textReviewController.text = figureReview!.textReview;
      starsController.text = figureReview!.stars.toString();

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(widget.figureName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  background: Paint()
                    ..color = Colors.blue
                    ..strokeWidth = 20
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: Colors.white,
                )),

            Container(
              height: 15,
            ),
            TextField(
              controller: textReviewController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Review",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            GFRating(
              value: figureReview!.stars.toDouble(),
              onChanged: (value) {
                setState(() {
                  figureReview!.stars = value.toInt();
                });
              },
              showTextForm: true,
              controller: starsController,
              suffixIcon: GFButton(
                type: GFButtonType.transparent,
                onPressed: () {
                  setState(() {
                    figureReview!.stars = int.parse(starsController.text);
                  });
                },
                child: const Text('Rate'),
              ),
            ),

            // TextField(
            //   controller: starsController,
            //   style: textStyle,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: "Number of stars",
            //     labelStyle: textStyle,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }
  }
}
